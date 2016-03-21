data_source.csv #元の何もいじられていないデータ
uniqw           #create_dataで使うuniq -wをc言語で実装したもの
brew install gsed #必要

###sh
double_data.sh #ダブリ(番号)データを全部出力する.
create_data.sh #下に余分に追加されているデータを削除する.
               #明らかに異常なデータがあるので修正(体重532.8kg)
	       #ダブリを削除する. |sed|awk|uniq -c|grep "  2"で確認 
year_get.sh    #指定継続年数があるデータの番号を抽出 [引数1]
	       #全ての年度から指定データ数のみ取り出せる > .data.csv
	       #トレーニング(n-1)テスト(1)に分解する .taraining.csv .test.csv

###r
pair_plot.r  #pair_plotをするためのスクリプト [data2を作るために実行必須]
pca_gmm.r #保健指導効果のアニメーションによる可視化(GMM有り)
pca_basic.r #GMMなしのアニメーション可視化

###なんかおかしいところ
下から15行目まで番号がない.あとheaderがもうひとつある.
13733 体重532.8kg
38888 体重164.61kg(近年のデータと比べて異常)
番号と年度でダブっているデータが51件ある.
