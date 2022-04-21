void func(){

}
void kmain() {
	char* video_memory = (char *) 0xb8000;
	*video_memory = 'a';
}