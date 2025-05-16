# APBench_Space
 APBench for Space Engineering code repo.

# APBench
APBench_Alpha.json, APBench_Beta.json, APBench_Gamma.json are made publicaly available at https://huggingface.co/datasets/woodywu/APBench. 

## Benchmarking_APBench
The Benchmarking_APBench folder contains multiple benchmarking scripts covering the major models used in evaluating model performance on APBench. 

### Usage
Each script stands along and could run directly with necessary API information.

- **`Anthropic_Claude_3.7_Sonnet.ipynb`** runs the benchmarking for Claude 3.7 Sonnet.
- **`OpenAI_o4-mini.ipynb`** runs the benchmarking for openAI models.
- **`XAI_Grok-Beta-mini-highreasoning`** runs the benchmarking for Grok 3 Mini (high).
- **`AstroSage-8b.ipynb`** runs the benchmarking for AstroSage 8B or other models hosted on HuggingFace.
- **`Ollama_deepseek_R1.ipynb`** runs the benchmarking for R1 32B or other models on Ollama.
- **`Llamas_Families_3.1.ipynb`** runs the benchmarking for Llama 3.1 or other models hosted on HuggingFace.
- **`Script_Result_Evolution.m`** is a stand-along script for the benchmarking evolution and prediction plot.

## Semantic_Clustering

The semantic clustering contains a Jupyter Notebook and supporting files for performing semantic clustering analysis on language model outputs and a reference dataset.

### Files and Their Intents

- **`Clusters_Code.ipynb`**:  
  The main Jupyter Notebook that performs semantic analysis using bigram extraction, spectral clustering, t-SNE visualization, and Phi coefficient-based labeling. It analyzes six language models (AstroSage, AstroLlama2, Claude 3.7 Sonnet, Grok 3 Mini (high), Llama 3.1 8B, o4-mini) with 2, 4, and 8 clusters, and provides a reference analysis using the APBench_Gamma dataset. Running this notebook generates SVG plots for visualization.

- **`APBench_Gamma.json`**:  
  A JSON file containing the APBench-Gamma dataset, used as a reference for comparing model outputs. It includes solution text blocks for semantic clustering analysis.

- **`AstroSage.txt`, `AstroLlama2.txt`, `Claude 3.7 Sonnet.txt`, `Grok 3 Mini (high).txt`, `Llama 3.1 8B.txt`, `o4-mini.txt`**:  
  Text files containing the output replies from the respective language models. These files are processed to extract bigrams and perform clustering analysis.

### Usage
1. Upload all files to a Google Colab environment.
2. Install required dependencies by running:  
   ```
   !pip install numpy==1.26.4 matplotlib==3.8.4 scikit-learn==1.4.2 scipy==1.13.0
   ```
3. Execute the cells in `Clusters_Code.ipynb` sequentially to generate clustering visualizations.
4. Check the Colab file explorer for generated SVG files (`comparison_models_2_clusters.svg`, `comparison_models_4_clusters.svg`, `comparison_models_8_clusters.svg`, `reference_clusters_2_4_8.svg`).

### Notes
- Ensure all `.txt` files contain valid reply data and `APBench_Gamma.json` exists.
- The notebook runs independently in Colab with the provided files.
- Generated SVG files are saved in the current directory.

## FSI

FSI, Foundational Stability Indicator, is a novel callout to quantify a model's stability or ``stubbornness'' over a question with respect to its reference solution trajectory.

### Usage
- **`FSI_demo_Anthropic_Claude_3.7_Sonnet.ipynb`** calculates the FSI.
- **`results_summary_Claude 3.7 Sonnet.pkl`** is the generated result from calculating FSI.
- **`Script_FSI.ipynb provides the trajectory`** analysis and FSI value comparison from a generated file.
