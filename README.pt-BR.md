# Restauração de foto antiga (implementação oficial do PyTorch)

<img src='imgs/0001.jpg'/>

### Página do projeto | Papel (versão CVPR) | Artigo (versão do jornal) | Modelo Pré-treinado | Colab Demo 🔥

**Trazendo fotos antigas de volta à vida, CVPR2020 (oral)**

**Restauração de fotos antigas por meio da tradução profunda do espaço latente, PAMI em revisão**

Ziyu Wan1, Bo Zhang2, Dongdong Chen3, Pan Zhang4, Dong Chen2, Jing Liao1, Fang Wen2
1 Universidade da cidade de Hong Kong, 2Microsoft Research Ásia, 3Microsoft Cloud AI, 4USTC

## Novo

Agora você pode brincar com nosso Colab e testá-lo em suas fotos.

## Requerimento

O código é testado no Ubuntu com GPUs Nvidia e CUDA instalados. Python> = 3.6 é necessário para executar o código.

## Instalação

Clone o repositório Synchronized-BatchNorm-PyTorch para

```
cd Face_Enhancement / models / networks /
git clone https://github.com/vacancy/Synchronized-BatchNorm-PyTorch
cp -rf Synchronized-BatchNorm-PyTorch / sync_batchnorm.
cd ../../../
```

```
cd Global / detecção_models
git clone https://github.com/vacancy/Synchronized-BatchNorm-PyTorch
cp -rf Synchronized-BatchNorm-PyTorch / sync_batchnorm.
cd ../../
```

Baixe o modelo pré-treinado de detecção de pontos de referência

```
cd Face_Detection /
wget http://dlib.net/files/shape_predictor_68_face_landmarks.dat.bz2
bzip2 -d shape_predictor_68_face_landmarks.dat.bz2
cd ../
```

Baixe o modelo pré-treinado do Armazenamento de Blob do Azure, coloque o arquivo Face_Enhancement / checkpoints.zip em ./Face_Enhancement e coloque o arquivo Global / checkpoints.zip em ./Global. Em seguida, descompacte-os respectivamente.

```
cd Face_Enhancement /
wget https://facevc.blob.core.windows.net/zhanbo/old_photo/pretrain/Face_Enhancement/checkpoints.zip
descompacte checkpoints.zip
cd ../
cd Global /
wget https://facevc.blob.core.windows.net/zhanbo/old_photo/pretrain/Global/checkpoints.zip
descompacte checkpoints.zip
cd ../
```

Instale dependências:

```bash
pip install -r requisitos.txt
```

## Como usar?

**Nota: GPU pode ser definido como 0 ou 0,1,2 ou 0,2; use -1 para CPU

Como usar?

Nota: GPU pode ser definido como 0 ou 0,1,2 ou 0,2; use -1 para CPU

### 1) Pipeline completo

Você pode restaurar facilmente as fotos antigas com um simples comando após a instalação e baixar o modelo pré-treinado.

Para imagens sem riscos:

```bash
python run.py --input_folder [test_image_folder_path] \
              --output_folder [output_path] \
              - GPU 0
```

Para imagens arranhadas:

```bash
python run.py --input_folder [test_image_folder_path] \
              --output_folder [output_path] \
              - GPU 0 \
              --with_scratch
```

Nota: Por favor, tente usar o caminho absoluto. Os resultados finais serão salvos em ./output_path/final_output/. Você também pode verificar os resultados produzidos de diferentes etapas em output_path.

### 2) Detecção de arranhões

Atualmente, não planejamos lançar o conjunto de dados de fotos antigas arranhadas com rótulos diretamente. Se você deseja obter os dados emparelhados, pode usar nosso modelo pré-treinado para testar as imagens coletadas e obter os rótulos.

```bash
cd Global /
detecção de python.py --test_path [test_image_folder_path] \
                    --output_dir [output_path] \
                    --input_size [resize_256 | full_size | scale_256]
```
<img src='imgs/scratch_detection.png'>

### 3) Restauração Global

Uma rede de tradução de domínio tripleto é proposta para resolver a degradação estruturada e a degradação não estruturada de fotos antigas.

<p align="center">
<img src='imgs/pipeline.PNG' width="50%" height="50%"/>
</p>


```bash
cd Global /
python test.py --Scratch_and_Quality_restore \
               --test_input [test_image_folder_path] \
               --test_mask [máscara correspondente] \
               --outputs_dir [output_path]

python test.py --Quality_restore \
 --test_input [test_image_folder_path] \
 --outputs_dir [output_path]
```

<img src='imgs/global.png'>

### 4) Melhoramento facial

Usamos um gerador progressivo para refinar as regiões do rosto de fotos antigas. Mais detalhes podem ser encontrados em nossa submissão de periódicos e na pasta ./Face_Enhancement.

<p align="center">
<img src='imgs/face_pipeline.jpg' width="60%" height="60%"/>
</p>

<img src='imgs/face.png'>


> NOTA: Este repo é principalmente para fins de pesquisa e ainda não otimizamos o desempenho de >execução.

> Como o modelo é pré-treinado com imagens de 256 * 256, o modelo pode não funcionar idealmente para resolução arbitrária.

## Façam

 Limpe o código de teste
 Liberar modelo pré-treinado
 Demonstração Collab
 Substitua o módulo de detecção de rosto (dlib) por RetinaFace
 Liberar código de treinamento

## Citação

Se você acha nosso trabalho útil para sua pesquisa, considere citar os seguintes artigos :)

```
@inproceedings {wan2020bringing,
title = {Trazendo fotos antigas de volta à vida},
autor = {Wan, Ziyu e Zhang, Bo e Chen, Dongdong e Zhang, Pan e Chen, Dong e Liao, Jing e Wen, Fang},
booktitle = {Proceedings of the IEEE / CVF Conference on Computer Vision and Pattern Recognition},
páginas = {2747--2757},
ano = {2020}
}
```

```
@misc {2009.07047,
Autor = {Ziyu Wan e Bo Zhang e Dongdong Chen e Pan Zhang e Dong Chen e Jing Liao e Fang Wen},
Title = {Old Photo Restoration via Deep Latent Space Translation},
Ano = {2020},
Eprint = {arXiv: 2009.07047},
}
```

Se você também estiver interessado na colorização de fotos / vídeos legados, consulte este trabalho.

## Manutenção

Este projeto é mantido atualmente por Ziyu Wan e é apenas para uso em pesquisa acadêmica. Se você tiver alguma dúvida, sinta-se à vontade para entrar em contato com raywzy@gmail.com.

## Licença

Os códigos e o modelo pré-treinado neste repositório estão sob a licença MIT conforme especificado no arquivo LICENSE. Usamos nosso conjunto de dados rotulado para treinar o modelo de detecção de arranhões.

Este projeto adotou o Código de Conduta Open Source da Microsoft. Para obter mais informações, consulte as Perguntas frequentes do Código de Conduta ou entre em contato com opencode@microsoft.com com perguntas ou comentários adicionais.