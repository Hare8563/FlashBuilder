package common 
{
    import flash.utils.*;
    
    public class Conf extends Object
    {
        
        {
            ERROR_MESSAGE = new flash.utils.Dictionary();
            ERROR_MESSAGE[ERROR_RESOUCE_LOAD] = "リソースの読み込みに失敗しました";
            ERROR_MESSAGE[ERROR_TEXT_LOAD] = "サーバー通信にエラーが発生しました";
            ERROR_MESSAGE[ERROR_SECURITY] = "セキュリティエラーが発生しました";
        }

        public function Conf()
        {
            super();
            return;
        }

        public static const DIALOG_NO_REQUEST:String="戦友申請を行っていません";

        public static const BALLOON_TUTORIAL_GACHA_MESSAGE:String="これでチュートリアルは終了だよ。\nクリアのご褒美に新たな\nワルキューレ候補生をスカウトしたよ！";

        public static const FRIEND_REQUEST_MAX:int=20;

        public static const DIALOG_TITLE_GOLD_GACHA:String="ゴールドガチャ";

        public static const DIALOG_RAID_FAILURE:String="フォースが足りないため、\nレイドボスに挑戦することができません\nショップでアイテムを購入しますか？\n";

        public static const SERVER_FRIEND_APP:String="PcFriend/application";

        public static const ITEM_MODE_STAMINA:int=0;

        public static const GACHA_BANNER_TICKET:String="img/gacha/ticket/";

        public static const GACHA_BANNER_R18:String="img/gacha/r18/";

        public static const SERVER_HEAL:String="PcUser/heal/";

        public static const DIALOG_FORCE_TITLE:String="フォース回復";

        public static const IMAGE_DIR:String="img/";

        public static const DIALOG_SALE_RARE:String="選択したカードの中に、\nUC以上のカードが含まれます\n本当に売却しますか？";

        public static const SERVER_GACHA:String="PcGacha";

        public static const BUTTON_NORMAL_LABEL:String="normal";

        public static const DIALOG_FRIEND_RELEASE:String="戦友を解除します\n次の戦友の解除まで[min]分間が\n必要となります\nよろしいですか?";

        public static const GACHA_MATERIAL:int=3;

        public static const EVENT_GENERAL_NAME:String="リーディ";

        public static const SERVER_CARD_MASTER:String="PcCardMaster/";

        public static const SERVER_PRESENT_RECEIPT:String="PcPresent/receipt/";

        public static const DIALOG_TITLE_COMMENT_EDIT:String="コメント編集";

        public static const SERVER_SESSION:String="PcSession/";

        public static const DIALOG_RAID_JOINT_MESSAFE:String="戦友に共闘申請を送信しました";

        public static const GET_ITEM_TEXT:String="がプレゼントに送られました";

        public static const DIALOG_PRESENT_GET:String="[num]件のプレゼントを\n受け取りました";

        public static const DIALOG_DECK_SAVE:String="デッキを保存します\nよろしいですか？";

        public static const SOUND_DIR:String="sound/";

        public static const SERVER_FAVORITE:String="PcLockCard/";

        public static const RAIDBOSS_IMAGE_DIR:String="img/raidboss/";

        public static const MONSTER_IMAGE_DIR:String="img/monster/";

        public static const STATUS_POINT_ATO:String="あと";

        public static const ERROR_TEXT_LOAD:int=10001;

        public static const SAVE_FILE_NAME:String="qow_setting";

        public static const DIALOG_TEXT_GACHA_STONE:String="魔力の石が足りません\n魔力の石を購入しますか？\n(魔力の石の所持数:[stone]個)";

        public static const DIALOG_LEAGUE_FAILURE:String="スタミナが足りないため、\nリーグに挑戦することができません\n魔力の石を購入しますか？\n(魔力の石の所持数:[stone]個)";

        public static const GACHA_GOLD:int=1;

        public static const BALLOON_QUEST_MESSAGE:String="クエストに向かう\nエリアを選んでね";

        public static const DIALOG_FRIEND_NOT_REQUEST:String="この戦友には申請することが\nできません";

        public static const DIALOG_DECK_NO_SAVE:String="デッキが編集されています\nデッキを保存しますか？";

        public static const NOTICE_FRIEND_GREET_NUM:String="[num]人の戦友に応援を送りました。[point]ガチャポイント獲得しました";

        public static const SERVER_FRIEND_CANCEL:String="PcFriend/cancellation";

        public static const DIALOG_STAMINA_ERROR:String="スタミナの回復が間もなく行われます。\n少し時間をおいて\nもう一度実行してください。";

        public static const SERVER_POWERUP:String="PcStrengtheningCard/";

        public static const DIALOG_TITLE_SALE:String="売　却";

        public static const SERVER_USER:String="PcUser/";

        public static const TEXT_CARD_MAXUP:String="カードの所持上限が増加しました\nカード所持上限 [before] → [after]\n(魔力の石の所持数:[stone]個)";

        public static const CONNECTION_NAME:String="qow_connection";

        public static const SERVER_LOGIN:String="PcLogin/";

        public static const SERVER_FRIEND_RELEASE:String="PcFriend/release";

        public static const SERVER_SALE:String="PcSaleCard/";

        public static const DIALOG_LEAGUE_TITLE:String="リーグ";

        public static const CARD_MAX_NUM:int=100;

        public static const ITEM_ICON60_DIR:String="img/icon60/";

        public static const GACHA_BANNER_SMALL:String="img/gacha/small/";

        public static const BALLOON_TUTORIAL_DECK_MESSAGE:String="早速冒険に出掛けて、\n彼女たちのワルキューレの力が\n覚醒するように進化させてみてね！";

        public static const SERVER_GACHA_LIST:String="PcGacha/getList";

        public static const DIALOG_TEXT_DECK_COST_OVER:String="デッキの合計コストが\n上限をオーバーしています\nデッキを組み直してください";

        public static const ITEM_MODE_FORCE:int=1;

        public static const SERVER_CARD_UPDATE:String="PcCard/update/";

        public static const EVENT_CG_HEIGHT:int=470;

        public static const DIALOG_MY_FRIEND_MAX:String="戦友数が上限に達しました\nこれ以上戦友の承認は行えません";

        public static const SERVER_GACHA_NORMAL:String="PcGachaNormal";

        public static const LEAGUE_WINNERS:String="league/winners.swf";

        public static const SERVER_MISSION_REWARD:String="PcChallenge/reward";

        public static const DIALOG_FORCE_MESSAGE:String="アイテムを使用して、\nフォースを回復しました\n\n(フォース：[num]/[num_max])";

        public static const SERVER_RAID_RANKING:String="PcRaidRanking/highRanking";

        public static const GET_ITEM_POINT:String="[num]ガチャポイントを手に入れた";

        public static const BG_IMAGE_DIR:String="img/bg/";

        public static const EVENT_GENERAL_TEXT:String="ん～。残念だけど、イベントシーンの続きはR18版でしか見れないよ。\n後でアルバムから見ることもできるから安心してね～。";

        public static const SERVER_RAID_JOINT:String="PcRaidBoss/jointStruggleRequestMember";

        public static const DIALOG_EVENT_TITLE:String="イベント";

        public static const DIALOG_TITLE_SHOP:String="ショップ";

        public static const DIALOG_QUEST_NO_STAMINA:String="スタミナが足りないため、\nクエストに挑戦することができません\n魔力の石を1つ使用して\nスタミナを回復しますか？\n(魔力の石の所持数:[stone]個)";

        public static const DIALOG_LEAGUE_HEAL:String="魔力の石を使用して、\nスタミナを回復しました\n(魔力の石の所持数:[stone]個)";

        public static const SERVER_QUEST_START:String="QuizAes/json";

        public static const DIALOG_TEXT_CLASSUP_NOMANEY:String="進化に必要な金額がありません";

        public static const DIALOG_FRIEND_SETTLED:String="この戦友はすでに戦友です";

        public static const DIALOG_FRIEND_MAX:String="相手の戦友数が上限に達しています\n戦友の承認を行うことはできません";

        public static const SERVER_GACHA_GOLD:String="PcGachaGold";

        public static const DIALOG_TITLE_DECK_COST_OVER:String="デッキコストオーバー";

        public static const SERVER_PRESENT:String="PcPresent";

        public static const DIALOG_DECK_CLASS:String="同じキャラクター名のワルキューレを\nデッキ内に複数登録することは\nできません。";

        public static const STATUS_POINT_LEVELUP:String="ポイントでレベルアップ!";

        public static const DIALOG_QUEST_DECK_COST_OVER:String="デッキの合計コストが\n上限をオーバーしています\nデッキを設定しますか？";

        public static const DIALOG_TITLE_DECK:String="デッキ";

        public static const DIALOG_TEXT_COMMENT_COMP:String="変更したコメントを保存しました";

        public static const DIALOG_BATTLE_ERROR:String="エラーコード : [error]\nバトル終了時にエラーが発生しました\nお手数ですがエラーコードを\n下のお問い合わせからご連絡ください";

        public static const DIALOG_TEXT_ERROR:String="エラー";

        public static const DIALOG_FRIEND_REQUEST_MAX:String="これ以上戦友の申請は行えません\n戦友の申請は合計[num]名まで行えます";

        public static const CHARACTER_IMAGE_DIR:String="img/chara/";

        public static const DIALOG_MISSION_FULL_ERROR:String="ミッションの進行数が上限です\nこれ以上ミッションを進行することは\nできません\n";

        public static const SERVER_MISSION_ACCEPT:String="PcChallenge/accept";

        public static const SERVER_PRESENT_SETTLED:String="PcPresent/settled_receipt/";

        public static const SERVER_TUTORIAL_GACHA:String="PcTutorialGacha/";

        public static const ERROR_SECURITY:int=10002;

        public static const EVENT_BANNER_DIR:String="img/event/";

        public static const GET_ITEM_GOLD:String="[num]ゴールドを手に入れた";

        public static const EVENT_SWF_DIR:String="img/event/";

        public static const DIALOG_RAID_DEAD_MESSAFE:String="このレイドボスは\n他の戦友により撃破されました";

        public static const SERVER_ALBUM:String="PcAlbum";

        public static const NORICE_MISSION_REWARD:String="ミッション報酬が[num]件受け取れます。";

        public static const SCREEN_HEIGHT:int=470;

        public static const TEXT_CARD_MAXUP_LIMIT:String="これ以上カードの所持上限を\n増やすことは出来ません";

        public static const GACHA_NORMAL:int=0;

        public static const TEXT_CARD_MAX:String="魔力の石を[use]個使用して\nカードの上限を[up]増加します\nよろしいですか?(最大[cardmax]まで)\n(魔力の石の所持数:[stone]個)";

        public static const DECK_CARD_MAX:int=6;

        public static const SERVER_STATUS:String="PcStatus";

        public static const SERVER_RAID_CHECK:String="PcRaidBoss/check";

        public static const SERVER_MISSION:String="PcChallenge/index";

        public static const SERVER_SHOP:String="PcShop/goodsList";

        public static const ERROR_RESOUCE_LOAD:int=10000;

        public static const SERVER_FRIEND_AID:String="PcFriend/aid";

        public static const DIALOG_HEAL_ITEM_MESSAGE:String="スタミナが足りません。アイテムを使用してスタミナを回復して\nください。(スタミナ：[num]/[num_max])";

        public static const DIALOG_EVENT_R18:String="R18モードでイベントシーンを\n閲覧しますか？\n「はい」を選んだ場合、\nページが遷移します";

        public static const DIALOG_TITLE_POWERUP:String="合　成";

        public static const DIALOG_HEAL_TITLE:String="スタミナ回復";

        public static const GACHA_TICKET:int=2;

        public static const SERVER_CARD:String="PcCard/";

        public static const SERVER_LOGIN_BONUS:String="PcLoginBonus";

        public static const DIALOG_MISSION_CANCEL:String="進行中のミッションを中止します\n発生条件を満たしていれば\nやり直すことが可能です\n\nミッションを中止しますか？";

        public static const TITLE_CARD_MAX:String="カード所持上限拡張";

        public static const DIALOG_QUEST_TITLE:String="クエスト";

        public static const GACHA_BANNER_LARGE:String="img/gacha/large/";

        public static const DIALOG_FORCE_ITEM_MESSAGE:String="フォースが足りません。アイテムを使用してフォースを回復して\nください。(フォース：[num]/[num_max])";

        public static const BALLOON_LEAGUE_MESSAGE:String="リーグ戦に挑戦して\nランクアップしよう！";

        public static const BUTTON_DEACTIVE_LABEL:String="deactive";

        public static const SERVER_GACHA_TICKET:String="PcGachaTicket";

        public static const DIALOG_TITLE_GACHA_ERROR:String="ガチャ";

        public static const NOTICE_FRIEND_GREET:String="[name]に応援を送りました。[point]ガチャポイント獲得しました";

        public static const SCREEN_WIDTH:int=760;

        public static const SERVER_FRIEND_PERMISSION:String="PcFriend/permission";

        public static const DIALOG_TITLE_FRIEND:String="戦　友";

        public static const DIALOG_TEXT_GOLD_GACHA:String="魔力の石[point]個消費して\nゴールドガチャを[num]回引きますか？";

        public static const SERVER_RAID_JOINT_REQUEST:String="PcRaidBoss/jointStruggleRequest";

        public static const FRIEND_MAX:int=20;

        public static const BUTTON_DOWN_LABEL:String="down";

        public static const SERVER_CHANCE_BATTLE:String="PcChanceBattle/json";

        public static const RAID_DISCOVERER:String="さんからの共闘依頼";

        public static const DIALOG_HEAL_MESSAGE:String="アイテムを使用して、\nスタミナを回復しました\n\n(スタミナ：[num]/[num_max])";

        public static const EVENT_CG_WIDTH:int=627;

        public static const DIALOG_TITLE_CLASSUP:String="進　化";

        public static const SERVER_OPENING:String="PcOpening/";

        public static const SERVER_BP_HEAL:String="PcUser/bp_heal";

        public static const DIALOG_QUEST_FAILURE:String="スタミナが足りないため、\nクエストに挑戦することができません\n魔力の石を購入しますか？\n(魔力の石の所持数:[stone]個)";

        public static const DIALOG_TEXT_COMMENT_ERR01:String="不適切なコメントです";

        public static const SERVER_QUEST:String="PcQuest";

        public static const DIALOG_TEXT_CARD_OVER_ERROR:String="カードの所持上限を超えるため\nガチャを実行できません\nカードの所持数を減らしてから\n再度行ってください";

        public static const DIALOG_TEXT_POWERUP_NOMANEY:String="合成に必要な金額がありません";

        public static const DIALOG_POWERUP_RARE:String="選択したカードの中に、\nUC以上のカードが含まれます\n本当に合成を実行しますか？";

        public static const SERVER_TUTORIAL:String="PcTutorial/";

        public static const DIALOG_TEXT_COMMENT_ERR02:String="サーバー通信エラーです";

        public static const BUTTON_OVER_LABEL:String="over";

        public static const DIALOG_MISSION_CANCEL_TITLE:String="ミッション中止確認";

        public static const BUTTON_SELECTED_LABEL:String="selected";

        public static const DIALOG_EVENT_END_ERROR:String="このイベントは終了したため、\nイベントに挑戦することは出来ません";

        public static const SERVER_RAID_TARGET:String="PcRaidBoss/target";

        public static const DIALOG_TITLE_CONNECT_ERROR:String="通信エラー";

        public static const SERVER_CLASSUP:String="PcEvolutionCard/";

        public static const CARD_IMAGE_DIR:String="img/card/";

        public static const DIALOG_MISSION_TITLE:String="ミッション";

        public static const DIALOG_CLASSUP_OK:String="HPと攻撃をLVMAXで10%、それ以外は5%\n引き継ぎます。さらに++進化時に、\nそれまでの進化に使用したカードが\n全てLVMAXの場合は、25%を引き継ぎます\nチャージスキルはベースのLVとなります";

        public static const SERVER_MISSION_DETAIL:String="PcChallenge/detail";

        public static const DIALOG_CLASSUP_RARE:String="選択したカードは、\nUC以上のカードです\n本当に進化を実行しますか？";

        public static const SERVER_RAID:String="PcRaidBoss";

        public static const DIALOG_PRESENT_TITLE:String="プレゼント";

        public static const DIALOG_TITLE_NORMAL_GACHA:String="ノーマルガチャ";

        public static const SWF_DIR:String="swf/";

        public static const DIALOG_RAID_JOINT_TITLE:String="共闘申請";

        public static const TEXT_CARD_MAXUP_STONE:String="魔力の石を[use]個使用して\nカードの上限を[up]増加します\n魔力の石が足りません\n魔力の石を購入しますか？\n(魔力の石の所持数:[stone]個)";

        public static const EVENT_SCENE_DIR:String="event/";

        public static const ITEM_ICON200_DIR:String="img/icon200/";

        public static const DIALOG_QUEST_HEAL:String="魔力の石を使用して、\nスタミナを回復しました\n(魔力の石の所持数:[stone]個)";

        public static const DIALOG_TEXT_DECK_SAVE:String="デッキを保存しました";

        public static const SERVER_USER_DECK:String="PcUser/updateDeckInfo/";

        public static const STATUS_POINT_RANKUP:String="ポイントでランクアップ!";

        public static const DIALOG_TEXT_NORMAL_GACHA:String="ガチャポイント[point]消費して\nノーマルガチャを[num]回引きますか？";

        public static const SERVER_CARD_MAXIMUMUP:String="PcCardMaximumUp/";

        public static const DIALOG_RAID_TITLE:String="レイドボス";

        public static const DIALOG_LEAGUE_NO_STAMINA:String="スタミナが足りないため、\nリーグに挑戦することができません\n魔力の石を1つ使用して\nスタミナを回復しますか？\n(魔力の石の所持数:[stone]個)";

        public static const SERVER_LEAGUE:String="PcLeague/getList";

        public static const DIALOG_TEXT_COMMENT_EDIT:String="コメントが保存されていませんが\nよろしいですか？";

        public static const DECK_MAX:int=4;

        public static const SERVER_FRIEND_GETLIST:String="PcFriend/getList";

        public static const DIALOG_CARD_MAX:String="カードの所持枚数がオーバーしています\n合成や売却で減らしてください\nカードページに移動しますか？";

        public static const DIALOG_QUEST_NO_RANK:String="ランクが足りないため、\nこのクエストに挑戦することはできません\nクエストクリアでポイントを獲得できます\n(ランクは右上のステータスから\n確認できます)";

        public static const DIALOG_DEVICE_CONNECT_ERROR:String="別の端末からログインされました\nプレイを継続するためには、\nブラウザを更新してください";

        public static const DIALOG_SHOP_BUY:String="購入が完了しました\n[name]";

        public static const DIALOG_NO_FRIEND:String="戦友ではありません";

        public static const TEXT_GET_GACHA:String="「[name]」を手に入れた";

        public static const DIALOG_WINDOW_CONNECT_ERROR:String="別のウィンドウからゲームが\n開始されました\nこちらのウィンドウは閉じてください";

        public static const DIALOG_FRIEND_RELEASE_TIME:String="戦友の解除には[min]分の\n間隔が必要です\nしばらくしてからお試しください";

        public static const GET_ITEM_STONE:String="魔力の石[num]個を手に入れた";

        public static const SERVER_MISSION_RETIRE:String="PcChallenge/retire";

        public static var ERROR_MESSAGE:flash.utils.Dictionary;
    }
}
