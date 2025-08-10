build_number   = "1.0"
release_number = "1"

cga_name       = "x4utestai"
default_region = "East US 2"

models = [
  {
    name     = "gpt-oss-120b"
    model    = "gpt-oss-120b"
    format   = "OpenAI-OSS"
    capacity = "250"
  },
  {
    name     = "model-router"
    model    = "model-router"
    version  = "2025-08-07"
    capacity = "500"
  },
  {
    name     = "gpt-5"
    model    = "gpt-5"
    version  = "2025-08-07"
    capacity = "150"
  },
  {
    name     = "gpt-5-mini"
    model    = "gpt-5-mini"
    version  = "2025-08-07"
    capacity = "200"
  },
  {
    name     = "gpt-5-nano"
    model    = "gpt-5-nano"
    version  = "2025-08-07"
    capacity = "200"
  },
  {
    name     = "gpt-4o"
    model    = "gpt-4o"
    version  = "2024-11-20"
    capacity = "25"
  },
  {
    name     = "gpt-4.1"
    model    = "gpt-4.1"
    version  = "2025-04-14"
    capacity = "150"
  },
  {
    name     = "gpt-4.1-mini"
    model    = "gpt-4.1-mini"
    version  = "2025-04-14"
    capacity = "200"
  },
  {
    name     = "gpt-4.1-nano"
    model    = "gpt-4.1-nano"
    version  = "2025-04-14"
    capacity = "200"
  },
  {
    name     = "o1"
    model    = "o1"
    version  = "2024-12-17"
    capacity = "20"
  },
  {
    name     = "o1-mini"
    model    = "o1-mini"
    version  = "2024-09-12"
    capacity = "200"
  },
  {
    name     = "o3-pro"
    model    = "o3-pro"
    version  = "2025-06-10"
    capacity = "20"
  },
  {
    name     = "o3"
    model    = "o3"
    version  = "2025-04-16"
    capacity = "20"
  },
  {
    name     = "o3-mini"
    model    = "o3-mini"
    version  = "2025-01-31"
    capacity = "200"
  },
  {
    name     = "o4-mini"
    model    = "o4-mini"
    version  = "2025-04-16"
    capacity = "200"
  },
  {
    name     = "grok-3"
    model    = "grok-3"
    format   = "xAI"
    capacity = "100"
  },
  {
    name     = "grok-3-mini"
    model    = "grok-3-mini"
    format   = "xAI"
    capacity = "100"
  },
  {
    name     = "Llama-3.3-70B-Instruct"
    model    = "Llama-3.3-70B-Instruct"
    format   = "Meta"
    version  = "5"
    capacity = "1"
  },
  {
    name     = "DeepSeek-R1-0528"
    model    = "DeepSeek-R1-0528"
    format   = "DeepSeek"
    capacity = "1"
  },
  {
    name     = "mistral-medium-2505"
    model    = "mistral-medium-2505"
    format   = "Mistral AI"
    capacity = "1"
  },
  {
    name     = "whisper"
    model    = "whisper"
    version  = "001"
    capacity = "2"
    sku_name = "Standard"
  },
  {
    name     = "FLUX.1-Kontext-pro"
    model    = "FLUX.1-Kontext-pro"
    format   = "Black Forest Labs"
    capacity = "1"
  },
  {
    name     = "FLUX-1.1-pro"
    model    = "FLUX-1.1-pro"
    format   = "Black Forest Labs"
    capacity = "1"
  },
  {
    name     = "dall-e-3"
    model    = "dall-e-3"
    version  = "3.0"
    capacity = "2"
    sku_name = "Standard"
    region   = "East US"
  },
  {
    name     = "gpt-image-1"
    model    = "gpt-image-1"
    version  = "2025-04-15"
    capacity = "2"
    region   = "West US 3"
  },
  {
    name     = "sora"
    model    = "sora"
    version  = "2025-05-02"
    capacity = "25"
    sku_name = "Standard"
  }
]
