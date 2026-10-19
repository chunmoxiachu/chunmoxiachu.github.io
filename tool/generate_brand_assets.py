#!/usr/bin/env python3
"""Generate the 春末夏初 favicon, app icons and Open Graph cover.

Usage:
    python3 tool/generate_brand_assets.py

Requires Pillow. All text is rendered from the fonts bundled in assets/fonts,
so the assets match the Flutter web typography.
"""

from __future__ import annotations

from pathlib import Path

from PIL import Image, ImageDraw, ImageFont

ROOT = Path(__file__).resolve().parents[1]
FONT_DIR = ROOT / "assets" / "fonts"
WEB_DIR = ROOT / "web"

BRAND_ZH = "\u6625\u672b\u590f\u521d"
BRAND_EN = "CHUNMO XIACHU"
LIME = (192, 254, 4)
INK = (17, 17, 17)
SKY = (200, 223, 235)
SKY_DEEP = (187, 214, 231)


def font(name: str, size: int) -> ImageFont.FreeTypeFont:
    return ImageFont.truetype(str(FONT_DIR / name), size)


def render_mark(size: int, glyph_ratio: float) -> Image.Image:
    """A flat lime tile with the 春 mark, centred on its ink bounding box."""
    canvas = Image.new("RGB", (size, size), LIME)
    draw = ImageDraw.Draw(canvas)
    glyph_font = font("NotoSansSC-SemiBold.ttf", int(size * glyph_ratio))
    bbox = glyph_font.getbbox("\u6625")
    width = bbox[2] - bbox[0]
    height = bbox[3] - bbox[1]
    draw.text(
        (
            (size - width) / 2 - bbox[0],
            (size - height) / 2 - bbox[1] - size * 0.006,
        ),
        "\u6625",
        font=glyph_font,
        fill=INK,
    )
    return canvas


def linear_gradient(width: int, height: int, top: tuple[int, int, int], bottom: tuple[int, int, int]) -> Image.Image:
    image = Image.new("RGB", (width, height))
    draw = ImageDraw.Draw(image)
    for y in range(height):
        mix = y / max(1, height - 1)
        draw.line(
            [(0, y), (width, y)],
            fill=tuple(round(a + (b - a) * mix) for a, b in zip(top, bottom)),
        )
    return image


def render_og_cover() -> Image.Image:
    width, height = 1200, 630
    image = linear_gradient(width, height, SKY, SKY_DEEP).convert("RGBA")

    grid = Image.new("RGBA", (width, height), (0, 0, 0, 0))
    grid_draw = ImageDraw.Draw(grid)
    for x in range(84, width, 94):
        grid_draw.line([(x, 0), (x, height)], fill=(17, 17, 17, 14), width=1)
    image = Image.alpha_composite(image, grid)

    draw = ImageDraw.Draw(image)
    mono = font("GeistMono.ttf", 25)
    brand_cn = font("NotoSansSC-Medium.ttf", 27)
    headline = font("NotoSansSC-SemiBold.ttf", 80)
    supporting = font("NotoSansSC-Medium.ttf", 27)

    brand_baseline = 170
    draw.text((84, brand_baseline), BRAND_EN, font=mono, fill=INK, anchor="ls")
    brand_width = draw.textlength(BRAND_EN, font=mono)
    draw.text((84 + brand_width + 16, brand_baseline), BRAND_ZH, font=brand_cn, fill=INK, anchor="ls")

    draw.text((84, 300), "\u628a AI \u7528\u8fdb", font=headline, fill=INK, anchor="ls")
    draw.text((84, 392), "\u771f\u5b9e\u4e1a\u52a1", font=headline, fill=INK, anchor="ls")
    draw.text(
        (84, 466),
        "AI \u54a8\u8be2 \u00b7 \u4f01\u4e1a\u5b9e\u6218\u57f9\u8bad \u00b7 FDE \u843d\u5730\u4ea4\u4ed8",
        font=supporting,
        fill=(52, 60, 66),
        anchor="ls",
    )
    draw.rectangle([84, 520, 264, 528], fill=LIME)

    glass = Image.open(ROOT / "assets" / "glass" / "hello_zh.png").convert("RGBA")
    glass_width = 360
    glass_height = round(glass.height * glass_width / glass.width)
    glass = glass.resize((glass_width, glass_height), Image.LANCZOS)
    image.alpha_composite(glass, (770, 150))

    mark = render_mark(64, 0.62).convert("RGBA")
    image.alpha_composite(mark, (1052, 520))
    return image.convert("RGB")


def main() -> None:
    standard = render_mark(1024, 0.64)
    maskable = render_mark(1024, 0.52)

    for size in (64, 192, 512):
        standard.resize((size, size), Image.LANCZOS).save(WEB_DIR / ("favicon.png" if size == 64 else f"icons/Icon-{size}.png"))

    for size in (192, 512):
        maskable.resize((size, size), Image.LANCZOS).save(WEB_DIR / f"icons/Icon-maskable-{size}.png")

    render_og_cover().save(WEB_DIR / "og-cover.png", optimize=True)
    print("Regenerated favicon, app icons and og-cover.png")


if __name__ == "__main__":
    main()
