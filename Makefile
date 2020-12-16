
.SILENT:
.DEFAULT_GOAL := help

COLOR_RESET = \033[0m
COLOR_COMMAND = \033[36m
COLOR_YELLOW = \033[33m
COLOR_GREEN = \033[32m
COLOR_RED = \033[31m

PROJECT := Bringing Old Photos Back to Life
PORT := 10001
SLEEPUNTILAPPSTARTS := 45

## Prints help message
help:
	printf "\n${COLOR_YELLOW}${PROJECT}\n------\n${COLOR_RESET}"
	awk '/^[a-zA-Z\-\_0-9\.%]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "${COLOR_COMMAND}$$ make %s${COLOR_RESET} %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST) | sort
	printf "\n"

## Install 1 - 
install1:
	cd Face_Enhancement/models/networks/
	git clone https://github.com/vacancy/Synchronized-BatchNorm-PyTorch
	cp -rf Synchronized-BatchNorm-PyTorch/sync_batchnorm .
	cd ../../../

## Install 2 - 
install2:
	cd Global/detection_models
	# git clone https://github.com/vacancy/Synchronized-BatchNorm-PyTorch
	cp -rf Synchronized-BatchNorm-PyTorch/sync_batchnorm .
	cd ../../

## Install 3 - 
install3: 
	cd Face_Detection/
	wget http://dlib.net/files/shape_predictor_68_face_landmarks.dat.bz2
	bzip2 -d shape_predictor_68_face_landmarks.dat.bz2
	cd ../

## Install 4 - 
install4:
	cd Face_Enhancement/
	wget https://facevc.blob.core.windows.net/zhanbo/old_photo/pretrain/Face_Enhancement/checkpoints.zip
	unzip checkpoints.zip
	cd ../
	cd Global/
	wget https://facevc.blob.core.windows.net/zhanbo/old_photo/pretrain/Global/checkpoints.zip
	unzip checkpoints.zip
	cd ../

## Install 5 - 
install5:
	pip install -r requirements.txt

## Install - 
install:
	make install1
	make install2
	make install3
	make install4
	make install5
