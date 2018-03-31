#!/bin/sh

echo -e '{
	"command":"GET",
	"name":"ExamSolutions.pdf",
	"length":128,
	"offset":-129
	 }' | nc 127.0.0.1 6666
