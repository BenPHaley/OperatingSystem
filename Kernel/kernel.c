// First kernel written. Keeping it simple because I can 
// add more to it later
void main () {
	// Pointer to the first text cell of the
	// Video Graphics Array
	char* video_graphics = (char*) 0xb8000;
	*video_graphics = 'X';
}
