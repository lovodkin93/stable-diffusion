import json






def main():
    outdir_json = r"/home/nlp/sloboda1/collaborations/royi/stable-diffusion/data/prompts_list_file_bowl.json"
    json_dict = [{"prompts": ["a bowl", "red"], "proportions": [1, 1]},
                 {"prompts": ["a bowl", "red"], "proportions": [1, 0.5]},
                 {"prompts": ["a bowl", "red"], "proportions": [0.5, 1]},
                 {"prompts": ["a bowl", "red"], "proportions": [0.5, 0.5]},
                 {"prompts": ["a bowl", "red"], "proportions": [0.75, 0.25]},
                 {"prompts": ["a bowl", "red"], "proportions": [0.25, 0.75]}]


    with open(outdir_json, 'w') as f:
        for item in json_dict:
            f.write(json.dumps(item) + "\n")


if __name__ == "__main__":
    main()