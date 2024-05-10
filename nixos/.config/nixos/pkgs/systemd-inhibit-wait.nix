{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "systemd-inhibit-wait";

  runtimeInputs = [ pkgs.systemd ];

  text = ''
    # https://github.com/systemd/systemd/issues/14045#issuecomment-1683764309

    # After the system woke up, it may be still in 'sleep' state for a
    # brief period. This causes sytemd-inhitit to fail with "Failed to
    # inhibit: The operation inhibition has been requested for is
    # already running". Therefore, we have to potentially try multiple
    # times until we can take the sleep inhibit lock. See
    # https://github.com/systemd/systemd/issues/14045

    declare -ir WAIT_INHIBITED_SECS=180
    for I in $(seq 1 ''${WAIT_INHIBITED_SECS}); do
    	if [[ ''${I} -eq ''${WAIT_INHIBITED_SECS} ]]; then
    		>&2 echo "Failed to take inhibit lock after ''${I} seconds"
    		exit 1
    	fi
    	# Check if we would be able to take the inhibit lock.
    	if systemd-inhibit true; then
    		echo "Inhibit lock free after ''${I} seconds"
    		break
    	fi
    	sleep 1
    done
    exec systemd-inhibit "$@"
  '';
}
