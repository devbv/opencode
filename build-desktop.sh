#!/bin/bash
set -e

# OpenCode Desktop 빌드 자동화 스크립트
# 사용법: ./build-desktop.sh

echo "🔨 OpenCode Desktop 빌드 시작..."
echo ""

# 색상 정의
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 환경변수 설정
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$HOME/.cargo/bin:$PATH"

# 사전 요구사항 확인
echo -e "${BLUE}📋 사전 요구사항 확인 중...${NC}"

if ! command -v bun &> /dev/null; then
    echo -e "${RED}❌ Bun이 설치되어 있지 않습니다.${NC}"
    echo "다음 명령으로 설치하세요:"
    echo "  curl -fsSL https://bun.sh/install | bash"
    exit 1
fi
echo -e "${GREEN}✓ Bun $(bun --version) 설치됨${NC}"

if ! command -v rustc &> /dev/null; then
    echo -e "${RED}❌ Rust가 설치되어 있지 않습니다.${NC}"
    echo "다음 명령으로 설치하세요:"
    echo "  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y"
    exit 1
fi
echo -e "${GREEN}✓ Rust $(rustc --version | cut -d' ' -f2) 설치됨${NC}"

if ! command -v cargo &> /dev/null; then
    echo -e "${RED}❌ Cargo가 설치되어 있지 않습니다.${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Cargo $(cargo --version | cut -d' ' -f2) 설치됨${NC}"

echo ""

# 플랫폼 감지
PLATFORM=""
SIDECAR_NAME=""
OS="$(uname -s)"
ARCH="$(uname -m)"

case "$OS" in
    Darwin)
        if [ "$ARCH" = "arm64" ]; then
            PLATFORM="darwin-arm64"
            SIDECAR_NAME="opencode-cli-aarch64-apple-darwin"
        else
            PLATFORM="darwin-x64"
            SIDECAR_NAME="opencode-cli-x86_64-apple-darwin"
        fi
        ;;
    Linux)
        PLATFORM="linux-x64"
        SIDECAR_NAME="opencode-cli-x86_64-unknown-linux-gnu"
        ;;
    MINGW*|MSYS*|CYGWIN*)
        PLATFORM="windows-x64"
        SIDECAR_NAME="opencode-cli-x86_64-pc-windows-msvc.exe"
        ;;
    *)
        echo -e "${RED}❌ 지원되지 않는 플랫폼: $OS${NC}"
        exit 1
        ;;
esac

echo -e "${BLUE}🖥️  감지된 플랫폼: $PLATFORM${NC}"
echo ""

# 단계 1: OpenCode CLI 빌드
echo -e "${BLUE}📦 1/3: OpenCode CLI 빌드 중...${NC}"
if [ -f "./packages/opencode/dist/opencode-${PLATFORM}/bin/opencode" ]; then
    echo -e "${YELLOW}⚠️  기존 빌드가 존재합니다. 재빌드하시겠습니까? (y/N)${NC}"
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        rm -rf "./packages/opencode/dist/opencode-${PLATFORM}"
        ./packages/opencode/script/build.ts --single
    else
        echo -e "${GREEN}✓ 기존 빌드 사용${NC}"
    fi
else
    ./packages/opencode/script/build.ts --single
fi
echo -e "${GREEN}✓ CLI 빌드 완료${NC}"
echo ""

# 단계 2: Sidecar 복사
echo -e "${BLUE}📋 2/3: Sidecar 준비 중...${NC}"
mkdir -p packages/desktop/src-tauri/sidecars

CLI_PATH="./packages/opencode/dist/opencode-${PLATFORM}/bin/opencode"
SIDECAR_PATH="./packages/desktop/src-tauri/sidecars/${SIDECAR_NAME}"

if [ ! -f "$CLI_PATH" ]; then
    echo -e "${RED}❌ CLI 바이너리를 찾을 수 없습니다: $CLI_PATH${NC}"
    exit 1
fi

cp "$CLI_PATH" "$SIDECAR_PATH"
chmod +x "$SIDECAR_PATH"
echo -e "${GREEN}✓ Sidecar 복사 완료: $SIDECAR_NAME${NC}"
echo ""

# 단계 3: Desktop 앱 빌드
echo -e "${BLUE}🚀 3/3: Desktop 앱 빌드 중...${NC}"
echo -e "${YELLOW}이 작업은 3-5분 정도 소요될 수 있습니다...${NC}"
cd packages/desktop
bun run tauri build
cd ../..
echo -e "${GREEN}✓ Desktop 앱 빌드 완료${NC}"
echo ""

# 빌드 결과 표시
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✅ 빌드 완료!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "생성된 파일:"

if [ "$OS" = "Darwin" ]; then
    APP_PATH="packages/desktop/src-tauri/target/release/bundle/macos/OpenCode Dev.app"
    DMG_PATH=$(find packages/desktop/src-tauri/target/release/bundle/dmg -name "*.dmg" -type f 2>/dev/null | head -1)

    if [ -d "$APP_PATH" ]; then
        echo -e "  ${BLUE}📱 App:${NC} $APP_PATH"
    fi
    if [ -f "$DMG_PATH" ]; then
        echo -e "  ${BLUE}💿 DMG:${NC} $DMG_PATH"
    fi

    echo ""
    echo "실행 방법:"
    echo -e "  ${YELLOW}open \"$APP_PATH\"${NC}"
elif [ "$OS" = "Linux" ]; then
    DEB_PATH=$(find packages/desktop/src-tauri/target/release/bundle/deb -name "*.deb" -type f 2>/dev/null | head -1)
    APPIMAGE_PATH=$(find packages/desktop/src-tauri/target/release/bundle/appimage -name "*.AppImage" -type f 2>/dev/null | head -1)

    if [ -f "$DEB_PATH" ]; then
        echo -e "  ${BLUE}📦 DEB:${NC} $DEB_PATH"
    fi
    if [ -f "$APPIMAGE_PATH" ]; then
        echo -e "  ${BLUE}📦 AppImage:${NC} $APPIMAGE_PATH"
    fi
else
    EXE_PATH=$(find packages/desktop/src-tauri/target/release/bundle -name "*.exe" -type f 2>/dev/null | head -1)
    MSI_PATH=$(find packages/desktop/src-tauri/target/release/bundle/msi -name "*.msi" -type f 2>/dev/null | head -1)

    if [ -f "$EXE_PATH" ]; then
        echo -e "  ${BLUE}📦 EXE:${NC} $EXE_PATH"
    fi
    if [ -f "$MSI_PATH" ]; then
        echo -e "  ${BLUE}📦 MSI:${NC} $MSI_PATH"
    fi
fi

echo ""
echo -e "${BLUE}📚 더 많은 정보: DESKTOP_BUILD_GUIDE.ko.md${NC}"
