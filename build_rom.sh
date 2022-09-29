# sync rom
repo init --depth=1 --no-repo-verify -u repo init -u https://github.com/ResurrectionRemix-Revived/platform_manifest.git -b Q -g default,-mips,-darwin,-notdefault
git clone https://github.com/zhantech/local_manifest.git --depth 1 -b rr-tissot .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
export KBUILD_BUILD_USER="ZHANtech"; export KBUILD_BUILD_HOST="gatotkaca"
export TZ=Asia/Dhaka #put before last build command
brunch rr_tissot-user

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
