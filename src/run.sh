#!/usr/bin/env bash
set -Ceu
#---------------------------------------------------------------------------
# ESPnetをインストールする
# CreatedAt: 2021-01-31
#---------------------------------------------------------------------------
Run() {
	THIS="$(realpath "${BASH_SOURCE:-0}")"; HERE="$(dirname "$THIS")"; PARENT="$(dirname "$HERE")"; THIS_NAME="$(basename "$THIS")"; APP_ROOT="$PARENT";
	cd "$HERE"
	UpdatePip() {
		pip3 install --upgrade pip3 setuptools
		pip install --upgrade pip setuptools
	}
	InstallTools() {
		sudo apt install -y cmake sox libsndfile1-dev ffmpeg flac libatlas-base-dev
	}
	Download() {
		git clone https://github.com/kaldi-asr/kaldi.git
		git clone https://github.com/espnet/espnet
	}
	Build() {
		InstallPyOpenJTalk() {
			pip install numpy
			pip install cython
			./installers/install_pyopenjtalk.sh
		}
		cd espnet/tools
		ls -s ../../kaldi/ .
		./setup_venv.sh $(command -v python3)
		. activate_python.sh
		InstallPyOpenJTalk
		make
		. ./activate_python.sh; python3 check_install.py
	}
	UpdatePip
	InstallTools
	Download
	Build
}
Run "$@"
