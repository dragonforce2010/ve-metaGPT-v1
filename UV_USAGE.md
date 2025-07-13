# MetaGPT 项目使用 UV 管理依赖指南

本项目已迁移到使用 [uv](https://github.com/astral-sh/uv) 来管理 Python 依赖。uv 是一个极快的 Python 包管理器和项目管理器，能够显著提升开发体验。

## 快速开始

### 1\. 安装 uv

```bash
# 使用官方安装脚本
curl -LsSf https://astral.sh/uv/install.sh | sh

# 或者使用 homebrew (macOS)
brew install uv

# 或者使用 pip
pip install uv
```

### 2\. 设置开发环境

```bash
# 运行自动化设置脚本
chmod +x setup_dev.sh
./setup_dev.sh
```

### 3\. 激活环境

```bash
# 激活虚拟环境
source activate_env.sh

# 或者手动激活
source .venv/bin/activate
```

## 常用命令

### 依赖管理

```bash
# 安装项目依赖
uv sync

# 添加新依赖
uv add requests
uv add pytest --dev  # 添加开发依赖

# 添加可选依赖
uv add tensorflow --optional android_assistant

# 移除依赖
uv remove requests

# 更新依赖
uv update
uv update requests  # 更新特定包

# 查看依赖树
uv tree
```

### 项目运行

```bash
# 在虚拟环境中运行命令
uv run python examples/di/crawl_webpage.py
uv run pytest
uv run metagpt

# 运行脚本
uv run python -m metagpt.roles.di.data_interpreter
```

### 环境管理

```bash
# 查看 Python 版本
uv python list

# 设置项目 Python 版本
uv python pin 3.13.3

# 创建虚拟环境
uv venv

# 激活虚拟环境
source .venv/bin/activate
```

### 锁定文件管理

```bash
# 生成锁定文件
uv lock

# 更新锁定文件
uv lock --upgrade

# 导出 requirements.txt
uv export --format requirements-txt > requirements.txt
```

## 项目结构

```
MetaGPT/
├── pyproject.toml          # 项目配置和依赖定义
├── uv.lock                 # 锁定文件，确保可重现的构建
├── requirements.txt        # 导出的传统格式依赖文件
├── setup_dev.sh           # 开发环境设置脚本
├── activate_env.sh        # 环境激活脚本
├── .python-version        # 项目 Python 版本
└── .venv/                 # 虚拟环境目录
```

## 依赖组织

项目依赖被组织成以下几个组：

### 核心依赖

- 运行时必需的基础包
- 定义在 `[project.dependencies]` 中

### 可选依赖

- `selenium`: Web 自动化测试
- `search-google`: Google 搜索 API
- `search-ddg`: DuckDuckGo 搜索
- `rag`: 检索增强生成
- `android_assistant`: Android 助手功能
- `test`: 测试相关包
- `dev`: 开发工具
- `pyppeteer`: 浏览器自动化

### 开发依赖

- 定义在 `[tool.uv.dev-dependencies]` 中
- 包括测试、代码格式化、预提交钩子等

## 使用示例

### 开发新功能

```bash
# 1. 添加新依赖
uv add beautifulsoup4 lxml

# 2. 运行代码
uv run python examples/di/crawl_webpage.py

# 3. 运行测试
uv run pytest tests/

# 4. 代码格式化
uv run black .
uv run isort .
```

### 部署准备

```bash
# 1. 锁定依赖版本
uv lock

# 2. 导出生产环境依赖
uv export --no-dev --format requirements-txt > requirements-prod.txt

# 3. 构建包
uv build
```

### 与传统工具的对比

| 操作 | pip/virtualenv | uv |
| --- | --- | --- |
| 创建虚拟环境 | `python -m venv .venv` | `uv venv` |
| 激活环境 | `source .venv/bin/activate` | `source .venv/bin/activate` |
| 安装依赖 | `pip install -r requirements.txt` | `uv sync` |
| 添加依赖 | `pip install requests` | `uv add requests` |
| 运行命令 | `python script.py` | `uv run python script.py` |
| 锁定依赖 | `pip freeze > requirements.txt` | `uv lock` |

## 迁移说明

### 从 pip/requirements.txt 迁移

如果你之前使用 pip 和 requirements.txt：

1. 现有的 `requirements.txt` 文件仍然兼容
2. 建议使用 `uv sync` 而不是 `pip install -r requirements.txt`
3. 新的依赖添加使用 `uv add` 而不是手动编辑 requirements.txt

### 从 setup.py 迁移

项目已经完全迁移到 `pyproject.toml`：

- 包元数据现在在 `[project]` 部分
- 依赖定义在 `[project.dependencies]` 和 `[project.optional-dependencies]`
- 构建配置在 `[build-system]` 部分

## 故障排除

### 常见问题

1. **Python 版本不兼容**

   ```bash
   uv python pin 3.13.3
   ```

2. **依赖冲突**

   ```bash
   uv lock --upgrade
   ```

3. **缓存问题**

   ```bash
   uv cache clean
   ```

4. **重新创建环境**

   ```bash
   rm -rf .venv uv.lock
   uv sync
   ```

### 性能优化

- uv 使用并行下载和安装，比 pip 快 10-100 倍
- 全局缓存减少重复下载
- 锁定文件确保一致的构建

## 更多资源

- [uv 官方文档](https://docs.astral.sh/uv/)
- [uv GitHub 仓库](https://github.com/astral-sh/uv)
- [Python 包管理最佳实践](https://packaging.python.org/en/latest/guides/tool-recommendations/)

---

如有任何问题或建议，请在项目 issue 中提出