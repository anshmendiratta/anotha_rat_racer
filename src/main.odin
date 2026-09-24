package main

import "core:fmt"
import "core:os"
import "core:strings"

main :: proc() {

	IMAGE_HEIGHT :: 128
	IMAGE_WIDTH :: 128

	file_path, _ := os.open("output/first.ppm", os.File_Flags{.Read, .Write, .Trunc, .Create})
	file_contents := strings.builder_make()

	// write header/metadata.
	strings.write_bytes(
		&file_contents,
		transmute([]byte)(fmt.aprintfln("P3\n{} {}\n255", IMAGE_WIDTH, IMAGE_HEIGHT)),
	)

	for col in 0 ..< IMAGE_WIDTH {
		for row in 0 ..< IMAGE_HEIGHT {
			red := u64(255. * f16(col) / f16(IMAGE_WIDTH))
			green := u64(255. * f16(row) / f16(IMAGE_WIDTH))
			blue := u64(0)

			strings.write_u64(&file_contents, red)
			strings.write_byte(&file_contents, ' ')
			strings.write_u64(&file_contents, green)
			strings.write_byte(&file_contents, ' ')
			strings.write_u64(&file_contents, blue)
			strings.write_byte(&file_contents, '\n')
		}
	}

	file_contents_str := strings.to_string(file_contents)
	os.write_string(file_path, file_contents_str)
}

