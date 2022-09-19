
extra_name="child_bench"

from_file_prompt_list=$1
ddim_steps="200"
ckpt="/home/nlp/sloboda1/collaborations/royi/stable-diffusion/checkpoint/sd-v1-4.ckpt"
n_samples="1"
n_iter="1"
session="stable_diffusion_experiments"
outdir="outputs/${extra_name}"
configs="--from-file-prompt-list ${from_file_prompt_list} --ddim_steps ${ddim_steps} --plms --ckpt ${ckpt} --n_samples ${n_samples} --n_iter ${n_iter} --outdir ${outdir}"


command="conda activate ldm && CUDA_VISIBLE_DEVICES=0 python scripts/txt2img.py ${configs}"
# command="export WANDB_PROJECT=${WANDB_PROJECT} && source ~/controlled_reduction/controlled_reduction_models_dir/venvs/controlled_reduction_models_venv/bin/activate && cd ~/controlled_reduction/controlled_reduction_models_dir && python -m src.run_experiments ${config}" # adding the CUDA_VISIBLE_DEVICES=5,6,7 is for the DGX

# for preprocessing
# command="source ~/controlled_reduction/controlled_reduction_models_dir/venvs/controlled_reduction_models_venv/bin/activate && cd ~/controlled_reduction/controlled_reduction_models_dir && CUDA_VISIBLE_DEVICES=3 python -m src.preprocess_from_highlight_rows_to_document_rows ${config}"



tmux new-session -d -s $session
tmux send-keys -t $session "$command" C-m
tmux attach-session -t $session

