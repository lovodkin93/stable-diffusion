#!/bin/bash
.  ./argparse.bash || exit 1
argparse "$@" <<EOF || exit 1
parser.add_argument('-f', '--from-json-prompt-list', required=True)
parser.add_argument('--ddim-steps', default=200)
parser.add_argument('--ckpt', default="/home/nlp/sloboda1/collaborations/royi/stable-diffusion/checkpoint/sd-v1-4.ckpt")
parser.add_argument('--n-samples', default=1)
parser.add_argument('--n-iter', default=1)
parser.add_argument('--scale', default=7.5)
parser.add_argument('-o', '--subdir-name', required=True)
parser.add_argument('--cuda-visible-devices', default=0)
EOF




subdir_name="$SUBDIR_NAME" # subdir name under the "outputs" dir to save files

FROM_JSON_PROMPT_LIST="$FROM_JSON_PROMPT_LIST" # json file with the prompts and the proportions
ddim_steps="$DDIM_STEPS" # number of denoising steps
ckpt="$CKPT" # path to model checkpoint
n_samples="$N_SAMPLES"
n_iter="$N_ITER"
session="stable_diffusion_experiments_${subdir_name}"
outdir="outputs/${subdir_name}"
scale="$SCALE" # guidance scale


configs="--from-json-prompt-list ${FROM_JSON_PROMPT_LIST} --ddim_steps ${ddim_steps} --plms --ckpt ${ckpt} --n_samples ${n_samples} --n_iter ${n_iter} --outdir ${outdir} --scale ${scale}"

command="conda activate ldm && CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES} python scripts/txt2img.py ${configs}"




tmux new-session -d -s $session
tmux send-keys -t $session "$command" C-m
tmux attach-session -t $session

