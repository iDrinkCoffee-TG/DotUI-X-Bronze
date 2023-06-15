#include <stdio.h>
#include <string.h>

#include <fcntl.h>
#include <linux/input.h>
#include <linux/fb.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <unistd.h>

#define BUTTON_A	KEY_SPACE
#define BUTTON_B	KEY_LEFTCTRL

#define E_RELEASE	0
#define E_PRESS		1
#define E_REPEAT	2

int main(int argc , char* argv[]) {
	int any  = 0;
	int only = 0;

	// if (argc<1) {
	// 	puts("Usage: confirm [any|only]");
	// 	puts("  default: only A button confirms, only B button cancels");
	// 	puts("      any: any button confirms, none cancel");
	// 	puts("     only: only the A button confirms, none cancel");
	// 	return 0;
	// }

	if (argc>1) {
		char mode[4];
		strncpy(mode,argv[1],4);
		any  = !strncmp(mode, "any",  3);
		only = !strncmp(mode, "only", 4);
	}

	int ret = 0; // true in shell

	int input_fd = open("/dev/input/event0", O_RDONLY);
	if (input_fd != -1) {
		struct input_event event;
		while (read(input_fd, &event, sizeof(event))==sizeof(event)) {
			if (event.type==EV_KEY && event.value==E_PRESS) {
				if (any) {
					ret = event.code;
					break;
				} else if (event.code==BUTTON_A) {
					break;
				} else if (!only && event.code==BUTTON_B) {
					ret = 1; // false in shell terms
					break;
				}
			}
		}
		close(input_fd);
	}

	// clear screen
	// int fb0_fd = open("/dev/fb0", O_RDWR);
	// struct fb_var_screeninfo vinfo;
	// ioctl(fb0_fd, FBIOGET_VSCREENINFO, &vinfo);
	// int map_size = vinfo.xres * vinfo.yres * (vinfo.bits_per_pixel / 8); // 640x480x4
	// char* fb0_map = (char*)mmap(0, map_size, PROT_READ | PROT_WRITE, MAP_SHARED, fb0_fd, 0);
	// memset(fb0_map, 0, map_size);
	// munmap(fb0_map, map_size);
	// close(fb0_fd);

	return ret;
}
