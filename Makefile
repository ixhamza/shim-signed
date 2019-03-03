all:

check:
	mkdir -p build
	# Verifying that the image is signed with the correct key.
	sbverify --cert MicCorUEFCA2011_2011-06-27.crt shimx64.efi.signed
	# Verifying that we have the correct binary.
	sbattach --detach build/detached-sig shimx64.efi.signed 
	cp /usr/lib/shim/shimx64.efi build/shimx64.efi.signed
	sbattach --attach build/detached-sig build/shimx64.efi.signed
	cmp shimx64.efi.signed build/shimx64.efi.signed
	cp /usr/lib/shim/fbx64.efi.signed build
	cp /usr/lib/shim/mmx64.efi.signed build

clean:
	rm -rf build
