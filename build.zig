const std = @import("std");
const pkgs = @import("gyro").pkgs;

pub fn build(b: *std.build.Builder) void {
    // Standard release options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    const mode = b.standardReleaseOptions();

    const lib = b.addStaticLibrary("sveltec", "src/main.zig");
    lib.setBuildMode(mode);
    pkgs.addAllTo(lib);
    lib.install();

    var main_tests = b.addTest("src/main.zig");
    pkgs.addAllTo(main_tests);
    main_tests.setBuildMode(mode);

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&main_tests.step);
}
