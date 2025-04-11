# [ゴリラのガチャガチャ](https://appalling-amity-nezccommand-186871cb.koyeb.app/)
<a href="https://gyazo.com/aa199476b62c68c0f5b551eba4f1aa4e">
  <img src="https://i.gyazo.com/aa199476b62c68c0f5b551eba4f1aa4e.png" width="400" height="400" alt="Image from Gyazo" />
</a>

出てくるゴリラで気軽に運試しができるミニアプリです。  
自分が前回作った黒猫のクイズアプリのsession処理をベースに、より簡略化して気軽にボタンを押せるような設定にしてみています。  
今回は大部分でAIを活用し、それを人力で検証したり追加のアルゴリズムを書く練習として作成しました。
  
## 遊び方
* トップページから「1回回す」もしくは「10回回す」を選択すると、確率に応じて色々なゴリラが排出されます。
* 「10回回す」を選択した場合、一番下に10連ガチャの結果のような表示が追加されます。
* 「結果をシェアする」ボタンを押すと、引いたゴリラのうち最もレア度が高いものをXにシェアすることができます。
### 【注意】
今回はkoyebを用いて無料デプロイを行いましたが、無料なので処理が30秒くらい遅れることがあります。    
いずれは有料でリリースして快適さを追求したアプリケーションを作ってみたいです。
  
## アクションごとの簡単なコード解説
### GET indexアクション
非常に簡素ですが画像 ＋ 説明 ＋ 1回 or 10回回すのボタンのみのルートページです。  
結果画面でシェアされるURLもurl=#{root_url}でトップページを設定しています。
 
### POST resultアクション
resultアクションで回数に応じた抽選結果をsessionに保存します。  
今回は完全にランダムなガチャを回すため、ランダムな数字を抽出し、それに応じた排出結果を保存するコードとしています。  
when以下は排出率のネタバレになってしまうのでここには表記しません。気になる方はcontrollerの中身を確認してみてください。
```
    results = times.times.map do #timesはガチャが1回か10回かに合わせて変動します
      number = rand(1..100) #1から100までのランダムな数字をnumberに格納します

      gorilla =
        case number
        when ...
```

### GET show_resultアクション
POSTされたsessionを元にガチャの排出結果を表示します。　　
resultアクションをわざわざ2つに分けているのは、sessionを確実に保存し、結果ページでリダイレクトしても引き続き結果が表示されるようにするためです。  
(GETアクションで結果を表示させることで、リダイレクトした時にPOSTするものがなくエラーになる不具合を防ぐことができました)  
実はもっといい対処法があるかもしれないです。
  
  
@resultに保存された1回ごとの結果を直接画像の名前に結び付けて呼び出せるようにしているのがここすきポイントです。
```
<%= image_tag "#{res["result"]}.png", size: "400x400", alt: "ゴリラ画像" %>
```

    
シェアボタンについては、helper内で引いた結果から最もレア度の高いものを抽出するアルゴリズムを作成し、views内で呼び出してしています。
ここではレア度を一度数字に変換し、そこから最も大きい数字を抽出、それを再度レア度の文字列に戻すという作業を行っています。
今思うと、rand(1..100)で作成したnumberも保存して最大値を抽出、それに対応するgorillaを呼び出してもいいのかもしれないです。
```
  def rare_gorilla(results) 
    rarity = {
      "例1" => 5,
      "例2" => 4,
      "例3" => 3,
      "例4" => 2,
      "例5" => 1
    }
    results.max_by { |a| rarity[a["result"]] }["result"]
  end
```
  
## 今回のミニアプリ開発で学んだこと
* koyebでデプロイしてみましたが、Docker環境を使える場合は比較的沼りづらいと感じた。  
→ローカルで動く環境をほぼそのまま使えるため、render同様デプロイの敷居が下がるような気がします。
  
* CSSはかなり自由度が高く、編集が楽しいなと感じた。
→ちゃんとしたものを作る場合、使いやすさの次に見た目の部分が大事になってくるので、書き方をもっと覚えていきたいです。

* おみくじのようなもっと日本的なものにする予定が気づいたらソシャゲのガチャみたいになっていた。
→おかげで(？)世の中にあるガチャシミュレーターみたいなwebサービスは割と近いことやってるのかなと想像できました。
