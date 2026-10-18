#!/usr/bin/env python3
"""Rebuild the bundled CJK fallback fonts.

The site ships a subset of Noto Sans SC (SIL Open Font License) that only
contains the glyphs used by `lib/**/*.dart`, so Chinese copy renders instantly
and without reaching fonts.gstatic.com (which is unreachable for many visitors
in mainland China).

Usage:
    pip install fonttools brotli
    curl -L -o /tmp/NotoSansSC-VF.ttf \
      https://github.com/notofonts/noto-cjk/raw/main/Sans/Variable/TTF/Subset/NotoSansSC-VF.ttf
    python3 tool/subset_cjk_font.py /tmp/NotoSansSC-VF.ttf

Re-run this whenever new Chinese copy is added to the site.
"""

from __future__ import annotations

import argparse
import glob
import os

from fontTools import subset
from fontTools.ttLib import TTFont
from fontTools.varLib.instancer import instantiateVariableFont

# Weights registered in pubspec.yaml for the "Noto Sans SC" family.
WEIGHTS = {
    400: "assets/fonts/NotoSansSC-Regular.ttf",
    500: "assets/fonts/NotoSansSC-Medium.ttf",
    600: "assets/fonts/NotoSansSC-SemiBold.ttf",
}

EXTRA_GLYPHS = (
    "，。！？：；、·「」（）《》—…“”‘’【】"
    "!?.,:;/\\-–_+=%¥$#@&*()[]{}<>\"'`~^|｜"
    "0123456789"
    "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    " \u00a0©®™→↗↑←↓×•"
)


def collect_text(repo_root: str) -> str:
    chars: set[str] = set(EXTRA_GLYPHS)
    for path in glob.glob(os.path.join(repo_root, "lib", "**", "*.dart"), recursive=True):
        with open(path, encoding="utf-8") as handle:
            chars.update(handle.read())
    return "".join(sorted(chars))


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("variable_font", help="NotoSansSC-VF.ttf from notofonts/noto-cjk")
    parser.add_argument(
        "--repo-root",
        default=os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
    )
    args = parser.parse_args()

    text = collect_text(args.repo_root)
    print(f"subsetting {len(text)} characters")

    for weight, relative in WEIGHTS.items():
        font = TTFont(args.variable_font)
        instance = instantiateVariableFont(
            font, {"wght": weight}, inplace=True, updateFontNames=False
        )
        static_path = f"/tmp/NotoSansSC-{weight}.ttf"
        instance.save(static_path)

        out_path = os.path.join(args.repo_root, relative)
        subset.main(
            [
                static_path,
                f"--text={text}",
                f"--output-file={out_path}",
                "--layout-features=*",
                "--no-hinting",
                "--desubroutinize",
            ]
        )
        print(f"  {relative} ({os.path.getsize(out_path) // 1024} KB)")


if __name__ == "__main__":
    main()
