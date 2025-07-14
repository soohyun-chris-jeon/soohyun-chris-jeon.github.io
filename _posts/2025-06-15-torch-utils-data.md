---
layout: post
title:  "[PyTorch] 데이터 준비의 모든 것, torch.utils.data 패키지에 대해"
date:   2025-06-15 13:00:00 +0900
categories: [PyTorch]
tags: [PyTorch, torch.utils.data, data loader, Augmentation Deep Learning, AI]
pin: false
comments: true     # 댓글 기능 사용 (옵션)


---
## 🟣 Intro
- 우리가 다루는 데이터는 보통 깔끔하게 정리되어 있지 않음. 
- 이미지, 텍스트, 소리 등 형태도 제각각이고 양도 엄청나게 많다. 
- 이 데이터들을 모델이 **학습하기 좋은 형태로 "가공"하고 "공급"해주는 역할**이 바로 `torch.utils.data`의 핵심!
- 여기서 가장 중요한 두 가지 클래스는 `Dataset`과 `DataLoader`.

---

#### ⚪ Dataset 클래스: 말 그대로 데이터셋을 정의하는 클래스
PyTorch에서 쓰이는 데이터셋은 torch.utils.data.Dataset을 상속받아 디자인됨.

1) 미리 정의된 `ImageFolder` 데이터셋
2) 커스텀 데이터셋: 클래스를 만들때 포함되어야할 특별 메서드 3가지
    * __init__(self, ...)
    * __len__(self)
    * __getitem__(self, idx)


---


#### ⚪ DataLoader 클래스: 효율적인 데이터 공급을 위한 클래스
- **미니배치(Mini-batch)**: 전체 데이터를 한 번에 메모리에 올리고 학습하면 너무 비효율적이고 메모리도 부족하므로 데이터를 작은 묶음(미니배치)으로 나눠서 처리.

- **셔플(Shuffle)**: 매 에폭(epoch)마다 데이터 순서를 섞어줘야 모델이 데이터의 순서를 외우는 걸 방지하고 일반화 성능이 좋아짐

- **병렬 처리(Parallel Processing)**: 데이터를 불러오고 전처리하는 동안 여러 CPU 코어를 사용해서 데이터를 미리미리 준비해놓고 GPU에 빠르게 전달해주는 역할도 함.


#### 
```py
from torch.utils.data import Dataset, DataLoader

# 1. 커스텀 데이터셋 정의 (예시)
class MyCustomDataset(Dataset):
    def __init__(self, data, labels, transform=None):
        self.data = data # 이미지 파일 경로 리스트 등
        self.labels = labels
        self.transform = transform

    def __len__(self):
        return len(self.data)

    def __getitem__(self, idx):
        # 여기서 실제 데이터 로딩 및 전처리
        sample_data = self.data[idx]
        sample_label = self.labels[idx]
        if self.transform:
            sample_data = self.transform(sample_data)
        return sample_data, sample_label

# 2. Dataset 인스턴스 생성
my_dataset = MyCustomDataset(data=[...], labels=[...])

# 3. DataLoader로 감싸기
my_dataloader = DataLoader(my_dataset, batch_size=32, shuffle=True, num_workers=4)

# 이제 for 루프를 돌면서 데이터를 편하게 꺼내 쓸 수 있다
for batch_data, batch_labels in my_dataloader:
    # 이 안에서 모델 학습 코드를 작성
    # batch_data는 (32, 채널, 높이, 너비) 같은 형태의 텐서가 됨
    pass
```

---

## 🟣 torch.utils.data 요약
> `Dataset으로` 데이터를 포장하고, `DataLoader로` 효율적으로 모델에 공급한다

## Reference
[PyTorch Official Documentation (Data loading)](https://docs.pytorch.org/tutorials/beginner/data_loading_tutorial.html) 

