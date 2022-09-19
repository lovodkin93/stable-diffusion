import json






def main():
    outdir_json = r"/home/nlp/sloboda1/collaborations/royi/stable-diffusion/data/prompts_list_file.json"
    json_dict = [{"prompts": ["a child", "under", "a bench"],         "proportions":[1, 1, 1]},
                 {"prompts": ["a child", "under", "a bench"],         "proportions":[1, 0.5, 0.5]},
                 {"prompts": ["a child", "under", "a bench"],         "proportions":[0.5, 1, 0.5]},
                 {"prompts": ["a child", "under", "a bench"],         "proportions":[0.5, 0.5, 1]},
                 {"prompts": ["a child", "under", "a bench"],         "proportions":[0.3, 0.3, 0.3]},
                 {"prompts": ["a child", "under", "a bench"],         "proportions":[0.5, 0.25, 0.25]},
                 {"prompts": ["a child", "under", "a bench"],         "proportions":[0.25, 0.5, 0.25]},
                 {"prompts": ["a child", "under", "a bench"],         "proportions":[0.25, 0.25, 0.5]},
                 {"prompts": ["a kid", "under", "a bench"],         "proportions":[1, 1, 1]},
                 {"prompts": ["a kid", "under", "a bench"],         "proportions":[1, 0.5, 0.5]},
                 {"prompts": ["a kid", "under", "a bench"],         "proportions":[0.5, 1, 0.5]},
                 {"prompts": ["a kid", "under", "a bench"],         "proportions":[0.5, 0.5, 1]},
                 {"prompts": ["a kid", "under", "a bench"],         "proportions":[0.3, 0.3, 0.3]},
                 {"prompts": ["a kid", "under", "a bench"],         "proportions":[0.5, 0.25, 0.25]},
                 {"prompts": ["a kid", "under", "a bench"],         "proportions":[0.25, 0.5, 0.25]},
                 {"prompts": ["a kid", "under", "a bench"],         "proportions":[0.25, 0.25, 0.5]},
                 {"prompts": ["a kid under a bench"],                "proportions":[1]}]


    with open(outdir_json, 'w') as f:
        for item in json_dict:
            f.write(json.dumps(item) + "\n")


if __name__ == "__main__":
    main()