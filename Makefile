# Phony targets
.PHONY: all algorithms python sql clean

# Default target
all: algorithms python sql

# Algorithms study guide
algorithms:
	pandoc algorithms-study-guide.md --pdf-engine=lualatex --toc -o algorithms-study-guide.pdf

# Python handbook
python:
	pandoc python-handbook.md --pdf-engine=lualatex --toc -o python-handbook.pdf

# SQL handbook
sql:
	pandoc sql-handbook.md --pdf-engine=lualatex --toc -o sql-handbook.pdf

# Clean up generated files
clean:
	rm -f python-handbook.pdf sql-handbook.pdf
