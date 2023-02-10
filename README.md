# WebCaptions

A container setup that I use to automatically caption images. Build the container, use the `launch-env.sh` script, and run `whisper xyz.mov` to create captions.

Requires Jet :)

Source: https://github.com/openai/whisper/

## Usage

1. Place your media file in a directory by itself. For example:

```
jet:chom:% pwd
/scratch/wilnil/whisper_nonsense/chom
jet:chom:% ls
IMG_1045.MOV
```

2. While `cd`'ed in this directory, build the container
```
podman build . --tag webcaptions
```

2. Run the included script specifying the path to your directory, as well as the name of your media file:

```
./run_whisper_container.sh -p /scratch/wilnil/whisper_nonsense/chom/IMG_1045.MOV -d
```

(optionally, you can sepcify `-d` to launch your container in the background)

3. The container will launch using a command that might look something like this _(here's an example in case something broke)_

```
podman run --rm -it --hooks-dir=/usr/share/containers/oci/hooks.d/ --security-opt=label=disable -v ./MOV/test/:/workdir:Z -e WHISPER_VIDEO_PATH=IMG_0733.MOV --name=wilnil_img_0733 whisper_nonsense
```

4. Wait. It takes about two minutes to caption one minute of video, on my testing. Sometimes it goes faster. Sometimes it goes slower.

```
jet:whisper_nonsense:% ./run_whisper_container.sh -p /scratch/wilnil/whisper_nonsense/chom/IMG_1045.MOV                                                                                <main ✗>
100%|███████████████████████████████████████| 461M/461M [00:13<00:00, 35.3MiB/s]
Detecting language using up to the first 30 seconds. Use `--language` to specify the language
Detected language: English
[00:00.000 --> 00:06.760]  what's up this is a quick test of my container I'm just going to be speaking
[00:06.760 --> 00:18.600]  for a little bit to get some data and hopefully it will work yeah there's not
[00:18.600 --> 00:23.320]  really that much to say I guess I can talk about what I've been doing and
```

5. Eventually, you'll have caption files in your directory, and the container will clean itself up.

```
jet:chom:% ls
IMG_1045.MOV  IMG_1045.MOV.srt  IMG_1045.MOV.txt  IMG_1045.MOV.vtt
```
