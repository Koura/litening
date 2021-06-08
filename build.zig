const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) void {
    const target = b.standardTargetOptions(.{});

    const mode = b.standardReleaseOptions();

    const exe = b.addExecutable("litening", "src/main.zig");
    exe.setTarget(target);
    exe.setBuildMode(mode);
    exe.linkLibC();
    exe.linkSystemLibrary("SDL2");
    exe.install();

    b.default_step.dependOn(&exe.step);
    b.installArtifact(exe);

    const run = b.step("run", "Start the text editor");
    const run_cmd = exe.run();
    run.dependOn(&run_cmd.step);
}
