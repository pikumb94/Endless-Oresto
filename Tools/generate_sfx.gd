extends SceneTree
## Synthesizes the 8-bit sound effects into res://Audio/Sfx/.
## Run from the project folder:
##   godot --headless --path . --script res://Tools/generate_sfx.gd
## Each sound is a list of segments played back to back:
##   wave: "square" | "triangle" | "noise", from/to: frequency sweep (Hz),
##   duty: square pulse width, time: seconds, volume: 0..1 (fades out to 0 at the end of the segment).

const MIX_RATE := 22050
const OUT_DIR := "res://Audio/Sfx/"

const SOUNDS := {
	"jump": [
		{"wave": "square", "from": 300.0, "to": 820.0, "duty": 0.25, "time": 0.11, "volume": 0.6},
	],
	"point": [
		{"wave": "square", "from": 988.0, "to": 988.0, "duty": 0.5, "time": 0.07, "volume": 0.45},
		{"wave": "square", "from": 1319.0, "to": 1319.0, "duty": 0.5, "time": 0.16, "volume": 0.45},
	],
	"hit": [
		{"wave": "noise", "from": 6000.0, "to": 1500.0, "time": 0.09, "volume": 0.8},
		{"wave": "square", "from": 440.0, "to": 70.0, "duty": 0.5, "time": 0.38, "volume": 0.6},
	],
	"turtle_hop": [
		{"wave": "triangle", "from": 180.0, "to": 360.0, "time": 0.09, "volume": 0.7},
	],
	"restart": [
		{"wave": "square", "from": 523.0, "to": 523.0, "duty": 0.125, "time": 0.06, "volume": 0.4},
		{"wave": "square", "from": 659.0, "to": 659.0, "duty": 0.125, "time": 0.06, "volume": 0.4},
		{"wave": "square", "from": 784.0, "to": 784.0, "duty": 0.125, "time": 0.12, "volume": 0.4},
	],
}


func _init() -> void:
	DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path(OUT_DIR))
	for sound_name in SOUNDS:
		var path: String = OUT_DIR + sound_name + ".wav"
		var err := _synthesize(SOUNDS[sound_name]).save_to_wav(path)
		print("%s -> %s" % [path, error_string(err)])
	quit()


func _synthesize(segments: Array) -> AudioStreamWAV:
	var data := PackedByteArray()
	var phase := 0.0
	var noise_value := 0.0
	for seg: Dictionary in segments:
		var samples := int(seg.time * MIX_RATE)
		for i in samples:
			var t := float(i) / samples
			var freq: float = lerpf(seg.from, seg.to, t)
			phase = fmod(phase + freq / MIX_RATE, 1.0)
			var value := 0.0
			match seg.wave:
				"square":
					value = 1.0 if phase < seg.get("duty", 0.5) else -1.0
				"triangle":
					value = 4.0 * absf(phase - 0.5) - 1.0
				"noise":
					# Sample-and-hold noise: a new random value every cycle, like the NES noise channel.
					if phase < freq / MIX_RATE:
						noise_value = randf_range(-1.0, 1.0)
					value = noise_value
			value *= seg.volume * (1.0 - t)
			# Signed 8-bit PCM: the coarse quantization is part of the sound.
			data.append(int(round(value * 127.0)) & 0xFF)

	var stream := AudioStreamWAV.new()
	stream.format = AudioStreamWAV.FORMAT_8_BITS
	stream.mix_rate = MIX_RATE
	stream.stereo = false
	stream.data = data
	return stream
