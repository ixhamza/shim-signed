all:

check: check_$(EFI_ARCH)

check_x64 check_ia32:
	mkdir -p build
	# Verifying that the image is signed with the correct key.
	sbverify --cert MicCorUEFCA2011_2011-06-27.crt shim$(EFI_ARCH).efi.signed
	# Verifying that we have the correct binary.
	sbattach --detach build/detached-sig shim$(EFI_ARCH).efi.signed 
	cp /usr/lib/shim/shim$(EFI_ARCH).efi build/shim$(EFI_ARCH).efi.signed
	sbattach --attach build/detached-sig build/shim$(EFI_ARCH).efi.signed
	cmp shim$(EFI_ARCH).efi.signed build/shim$(EFI_ARCH).efi.signed
	sha256sum shim$(EFI_ARCH).efi.signed build/shim$(EFI_ARCH).efi.signed

check_aa64:
	echo "FOO"

clean:
	rm -rf build
