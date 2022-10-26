#!/bin/bash
.  ./argparse.bash || exit 1
argparse "$@" <<EOF || exit 1
parser.add_argument('--from-json-prompt-list', required=False)
parser.add_argument('--from-csv-prompt-list', required=False)
parser.add_argument('--save-encoder-output', action='store_true', default=False)
parser.add_argument('--project-on-null-space', action='store_true', default=False)
parser.add_argument('--inlp-projection', action='store_true', default=False)
parser.add_argument('--only-encode', action='store_true', default=False)
parser.add_argument('--ddim_steps', default=200)
parser.add_argument('--ckpt', default="/home/nlp/sloboda1/collaborations/royi/stable-diffusion2/checkpoint/sd-v1-4.ckpt")
parser.add_argument('--n_samples', default=1)
parser.add_argument('--n_iter', default=1)
parser.add_argument('--scale', default=7.5)
parser.add_argument('--plms', action='store_true', default=False)
parser.add_argument('--f', default=8)
parser.add_argument('-o', '--subdir-name')
parser.add_argument('--cuda-visible-devices', default=0)
EOF


subdir_name=""
if [ "$SUBDIR_NAME" ]; then
    subdir_name="$SUBDIR_NAME" # subdir name under the "outputs" dir to save files
fi

ddim_steps="$DDIM_STEPS" # number of denoising steps
ckpt="$CKPT" # path to model checkpoint
n_samples="$N_SAMPLES"
n_iter="$N_ITER"
session="stable_diffusion_experiments_${subdir_name}"
outdir="outputs/${subdir_name}"
scale="$SCALE" # guidance scale
f="$F"

added_params=""
if [ "$FROM_JSON_PROMPT_LIST" ]; then
    added_params="${added_params} --from-json-prompt-list $FROM_JSON_PROMPT_LIST"
fi

if [ "$FROM_CSV_PROMPT_LIST" ]; then
    added_params="${added_params} --from-csv-prompt-list $FROM_CSV_PROMPT_LIST"
fi



if [ "$SAVE_ENCODER_OUTPUT" ]; then
	added_params="${added_params} --save-encoder-output"
fi

if [ "$ONLY_ENCODE" ]; then
	added_params="${added_params} --only-encode"
fi

if [ "$PROJECT_ON_NULL_SPACE" ]; then
	added_params="${added_params} --project-on-null-space"
fi

if [ "$INLP_PROJECTION" ]; then
	added_params="${added_params} --inlp-projection"
fi



if [ "$PLMS" ]; then
	added_params="${added_params} --plms"
fi


if [ "$SUBDIR_NAME" ]; then
    added_params="${added_params} --outdir ${outdir}" # subdir name under the "outputs" dir to save files
fi


echo "added_params are ${added_params}"


configs="${added_params} --ddim_steps ${ddim_steps} --plms --ckpt ${ckpt} --n_samples ${n_samples} --n_iter ${n_iter} --scale ${scale} --f ${f}"

command="conda activate ldm && CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES} python scripts/txt2img.py ${configs}"




tmux new-session -d -s $session
tmux send-keys -t $session "$command" C-m
tmux attach-session -t $session

