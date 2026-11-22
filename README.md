# IC – Econometria Aplicada com Stata, R e Python

Repositório com os scripts, dados e resultados dos exemplos do livro de Wooldridge (capítulos 2 a 12), reproduzidos em três linguagens: **Stata**, **R** e **Python**.

## Estrutura do repositório

```
.
├── README.md
├── .gitignore
├── data/
│   ├── raw/
│   │   ├── xls/
│   │   └── DES/
│   └── processed/
│       ├── xls/
│       └── dta/
│           ├── cap02/
│           ├── cap03/
│           ├── ...
│           └── cap12/
├── scripts/
│   ├── cap02/
│   │   ├── do/
│   │   ├── py/
│   │   └── R/
│   ├── cap03/
│   │   ├── do/
│   │   ├── py/
│   │   └── R/
│   ├── ...
│   └── cap12/
└── outputs/
    ├── cap02/
    ├── cap03/
    ├── ...
    └── cap12/
```

## Lógica da organização

O repositório separa **o que entra**, **o que processa** e **o que sai**, usando o capítulo como eixo comum de organização.

```
data/raw  →  scripts  →  data/processed  +  outputs
(original)   (código)    (dados gerados)    (resultados)
```

Parte-se dos dados originais, roda-se o script de um capítulo e ele produz dois tipos de arquivo: dados modificados (`data/processed/`) e resultados finais (`outputs/`). Cada pasta tem uma função única, então é possível saber onde procurar um arquivo sem abrir nada.

## Descrição das pastas

### `data/raw/`
Dados originais do livro, **sem nenhuma alteração**. Os arquivos desta pasta nunca devem ser editados: se o dado original mudar, os resultados deixam de ser verificáveis.

- `xls/`: bases de dados em formato Excel (`.xls`).
- `DES/`: arquivos de descrição das variáveis (`.des`) que acompanham cada base. Funcionam como dicionário de variáveis.

Dado e documentação ficam em pastas separadas para não se misturarem.

### `data/processed/`
Dados gerados ou modificados ao rodar os exemplos. **Tudo o que está aqui pode ser apagado e recriado executando os scripts**, e é isso que o distingue de `raw/`.

- `xls/`: planilhas Excel modificadas a partir dos dados originais.
- `dta/`: arquivos `.dta` do Stata salvos a cada exemplo, **separados por capítulo (do 2 ao 12)**. Como há um arquivo por exemplo, a divisão por capítulo evita uma lista única difícil de navegar.

### `scripts/`
Códigos de cada exemplo, **separados por capítulo (do 2 ao 12)**. Dentro de cada capítulo há uma pasta por linguagem:

- `do/`: do-files do Stata (`.do`).
- `py/`: scripts em Python (`.py`).
- `R/`: scripts em R (`.R`).

Assim, o mesmo exemplo pode ser comparado entre as três linguagens abrindo a mesma posição em cada pasta.

### `outputs/`
Resultados produzidos pelos scripts (tabelas, gráficos e logs), **separados por capítulo (do 2 ao 12)**. Ficam separados dos dados por serem o produto final da análise.

## Convenções

- **Capítulo como eixo comum:** `data/processed/dta/`, `scripts/` e `outputs/` usam o mesmo padrão `capXX/`. Tudo do capítulo 5, por exemplo, está em `cap05/` nas três pastas.
- **Nomes de arquivo:** o mesmo nome-base nas três linguagens, para casar os arquivos de cada exemplo (ex.: `cap02_ex2_1.do`, `cap02_ex2_1.py`, `cap02_ex2_1.R`).
- **Caminhos relativos:** os scripts apontam para `data/raw/...` a partir da raiz do repositório, nunca para caminhos absolutos do computador.
- **Pastas vazias:** o Git não versiona pastas vazias; por isso, pastas ainda sem conteúdo possuem um arquivo `.gitkeep`.
- **Tamanho:** como cada `.dta` repete a base inteira, `data/processed/dta/` pode ficar pesado. Se necessário, ele é listado no `.gitignore` e recriado rodando os scripts.

## Como reproduzir

1. Clone o repositório:
   ```bash
   git clone https://github.com/SEU_USUARIO/NOME_DO_REPOSITORIO.git
   ```
2. Confirme que os dados originais estão em `data/raw/`.
3. Execute os scripts do capítulo desejado em `scripts/capXX/` (na linguagem de sua preferência), a partir da raiz do repositório.
4. Os dados tratados serão salvos em `data/processed/` e os resultados em `outputs/capXX/`.

## Ferramentas utilizadas

- Stata (versão: _preencher_)
- R (versão: _preencher_)
- Python (versão: _preencher_)

## Referência

WOOLDRIDGE, J. M. *Introdução à Econometria: uma abordagem moderna*. São Paulo: Cengage Learning.

## Autor

Ian – Ciências Econômicas, UFBA (PIBIC)
