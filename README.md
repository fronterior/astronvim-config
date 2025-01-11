# AstroNvim Template

- [AstroNvim Getting Started](https://docs.astronvim.com/) 문서의 Requirements 를 준비
- ~/.config/nvim 폴더에 git clone
- nvim 실행하면 플러그인 설치

## 설정 방법

### lua/community.lua

- [AstroNvim Community Repository Pages](https://astronvim.github.io/astrocommunity) 에 있는 플러그인 설치시 사용
- 플러그인끼리 충돌하지 않게 설정을 관리해주고 있어서 편리
  - 대부분의 플러그인 키 바인딩이 변경되어있으니 위 페이지에서 확인 후 사용
  - 위 페이지에 키 바인딩이 정의되어있지 않으면 플러그인 github의 기본 키 바인딩을 사용
- 재설정이 필요하면 `lua/plugins/user.lua` 파일에서 정의 가능

### lua/plugins/user.lua

- 일반적인 nvim 플러그인 설치
- 키 설정시 AstroNvim의 기본키와 겹치지 않게 설정해야 함

### lua/plugins/astroui.lua

- nvim테마 설정 가능
- 설치된 nvim테마는 `<leader>ft`로 확인 가능하지만 저장하려면 이 파일에 설정해줘야 함

### lua/plugins/astrolsp.lua

- lsp관련 설정가능
- `lua/plugins/user.lua`에서 설정한 키가 작동하지 않으면 여기에 정의하면 작동 (원인파악 필요)

### ⚠️ lua 파일 활성화

- lua 파일은 처음에는 활성화되어있지 않음
- 수정이 필요한 파일 첫줄에 작성된 아래 코드를 주석 처리해야 작동

```lua
if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
```
