Blood Test Visualization
====

Overview

- [Preprocessing/double_data.sh][1] - ダブりの血液検査データを表示
- [Preprocessing/create_data.sh][1] - ダブりのないデータの生成と明らかな異常値データの修正
- [Preprocessing/year_get.sh][1] - 2008~2014のデータより指定年数連続して存在する受診者のデータのみを取り出し
- [Preprocessing/pair_plot.r][1] - データセットの作成


- [Visualization/pca_basic.r][1] - 主成分分析を行い受診者変位をpngデータとして出力
- [Visualization/pca_gmm.r][1] - クラスタリング、主成分分析を行い受診者変位をpngデータとして出力


- [uniqw][1] - unixコマンド uniq -wをmac osで実装したもの

[1]: https://github.com/adam-p/markdown-here/wiki/Markdown-Here-Cheatsheet
[1]: https://github.com/adam-p/markdown-here/wiki/Markdown-Here-Cheatsheet
[1]: https://github.com/adam-p/markdown-here/wiki/Markdown-Here-Cheatsheet
[1]: https://github.com/adam-p/markdown-here/wiki/Markdown-Here-Cheatsheet
[1]: https://github.com/adam-p/markdown-here/wiki/Markdown-Here-Cheatsheet
[1]: https://github.com/adam-p/markdown-here/wiki/Markdown-Here-Cheatsheet


Attention


- 下から15行目まで番号がない.あとheaderがもうひとつある
- 13733 体重532.8kg
- 38888 体重164.61kg(近年のデータと比べて異常)
- 番号と年度でダブっているデータが51件ある
