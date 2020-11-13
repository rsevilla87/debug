# Using bcc-tools on a RHCOS system

Log in to the node using the debug image.
```
oc debug node/<nodeName> --image=quay.io/rsevilla/debug
```

And then create a couple of symlinks to the kernel-headers directory.

```
sh-5.0# ln -s /host/usr/src/kernels/$(uname -r) /usr/src/kernels/
sh-5.0# ln -s /host/lib/modules/$(uname -r) /lib/modules/
sh-5.0# cd /usr/share/bcc/tools/
sh-5.0# ./execsnoop 
PCOMM            PID    PPID   RET ARGS
sleep            944419 3280     0 /usr/bin/sleep 1
runc             944420 1458     0 /usr/bin/runc --root /run/runc state 874ff56684c5092e7446da7fac2831cfc047f01ec1ed3c21428d755e13604e69
conmon           944426 1458     0 /usr/libexec/crio/conmon -c 874ff56684c5092e7446da7fac2831cfc047f01ec1ed3c21428d755e13604e69 -n k8s_ovs-daemons_ovs-node-jtqlg_openshift-ovn-kubernetes_f8ac556b-d18b-431d-9926-8172b035a42d_0 -r /usr/bin/runc -p /tmp/pidfile228688217 -e -T 1 -l /tmp/crio-log-874ff56684c5092e7446da7fac2831cfc047f01ec1ed3c21428d755e13604e69446329572 --socket-dir-path /var/run/crio --log-level info --exec-process-spec /tmp/exec-process-316245235 ...
runc             944428 944427   0 /usr/bin/runc --root=/run/runc exec --pid-file /tmp/pidfile228688217 --process /tmp/exec-process-316245235 -d 874ff56684c5092e7446da7fac2831cfc047f01ec1ed3c21428d755e13604e69
exe              944436 944428   0 /proc/self/exe init
```

# Using bpftrace on a RHCOS system

Mount debugfs filesystem.
```
sh-5.0# mount -t debugfs none /sys/kernel/debug/
sh-5.0# bpftrace -l kprobe* | head
kprobe:trace_initcall_finish_cb
kprobe:initcall_blacklisted
kprobe:do_one_initcall
kprobe:trace_initcall_start_cb
kprobe:run_init_process
kprobe:try_to_run_init_process
kprobe:match_dev_by_uuid
kprobe:rootfs_mount
kprobe:name_to_dev_t
kprobe:bstat
```

Note: Some RHCOS builds are missing the kernel-devel package. This leads to the following error:

```
sh-5.0# bpftrace -e 'tracepoint:syscalls:sys_exit_mkdir{printf("Hello world"); }'
/bpftrace/include/clang_workarounds.h:14:10: fatal error: 'linux/types.h' file not found

```

I haven't found an easy fix for it, ideas are appreciated.
 
