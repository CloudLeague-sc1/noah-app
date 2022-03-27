CONTENTS_DIR := contents

.PHONY: fetch-content
fetch-content:
	rm -rf $(CONTENTS_DIR)
	curl https://cloudleague-sc1.github.io/noah-contents/generated.tar.gz --output generated.tar.gz
	mkdir -p $(CONTENTS_DIR)
	tar -xvzf generated.tar.gz --directory $(CONTENTS_DIR)
	rm generated.tar.gz
