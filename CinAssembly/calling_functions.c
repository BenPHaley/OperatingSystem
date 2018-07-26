void caller ();
int callee (int num);

void caller () {
	callee (0xdede);
}

int callee (int num) {
	return num;
}
