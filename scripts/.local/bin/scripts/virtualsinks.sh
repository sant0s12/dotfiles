# Declare your microphone and speakers
microphone="alsa_input.pci-0000_00_1f.3.analog-stereo"
speakers="alsa_output.pci-0000_00_1f.3.analog-stereo"

# Create the virtual sinks
pactl load-module module-null-sink sink_name=vsink_fx        sink_properties=device.description="vsink_fx"
pactl load-module module-null-sink sink_name=vsink_fx_mic    sink_properties=device.description="vsink_fx_mic"
pactl load-module module-null-sink sink_name=vsink_fx_to_spk sink_properties=device.description="vsink_fx_to_spk"
pactl set-sink-volume vsink_fx_to_spk '40%'

# Create the loopbacks
pactl load-module module-loopback latency_msec=35 adjust_time=3 sink=vsink_fx_mic source="$microphone"
pactl load-module module-loopback latency_msec=35 adjust_time=3 sink=vsink_fx_mic source=vsink_fx.monitor
pactl load-module module-loopback latency_msec=35 adjust_time=3 sink=vsink_fx_to_spk source=vsink_fx.monitor
pactl load-module module-loopback latency_msec=35 adjust_time=3 sink="$speakers" source=vsink_fx_to_spk.monitor
