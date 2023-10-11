import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:dyn_mouse_scroll/dyn_mouse_scroll.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_challenge/widget/parallax_motion_widget/offset_widget.dart';

/// File Description:
/// Author: HJ2023011
/// Date: 2023/10/10
/// 善战者无赫赫之功，善医者无煌煌之名

class ParallaxMotionPage extends StatelessWidget {
  const ParallaxMotionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _ParallaxMotionPage(),
          SizedBox(
              height: 60,
              child: MoveWindow(
                child: Container(
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios))
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

class _ParallaxMotionPage extends StatefulWidget {
  _ParallaxMotionPage({super.key});

  @override
  State<_ParallaxMotionPage> createState() => _ParallaxMotionPageState();
}

class _ParallaxMotionPageState extends State<_ParallaxMotionPage> {
  GlobalKey<ControllerOffsetWidgetState> testKey = GlobalKey();
  ScrollController? scrollController;
  late VoidCallback listener = () {
    testKey.currentState?.positionChange();
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DynMouseScroll(builder: (ctx, ScrollController controller, physics) {
      if (controller.hasListeners) {
        controller.removeListener(listener);
      }
      scrollController = controller;
      controller.addListener(listener);
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          controller: controller,
          physics: physics,
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 60,
              ),
            ),
            SliverToBoxAdapter(
              child: Text(
                "刺客伍六七",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverToBoxAdapter(
              child: Text(
                "剧情简介",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                    """《伍六七》是由啊哈娱乐（上海）有限公司与广州小疯文化传播有限公司联合出品的原创网络动画，于2018年4月25日起每周三于网络发布。 [1]
                    2019年10月23日，《伍六七》第二季《伍六七之最强发型师》播出。 [2] 2021年1月27日，《伍六七》第三季《伍六七之玄武国篇》播出。 [3] 2023年1月18日，《伍六七》第四季《伍六七之暗影宿命》播出。 [29]"""),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "登场角色",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text("""伍六七
配音：何小疯
热血、贱、内心柔软的本作男主角，没有记忆，身世是个谜，在大保健发廊做理发师，能够以气御剪，为了寻找自己的过去，走上了刺客之路。

鸡大保
配音：姜广涛
社会、拜金、讲义气、聪明的蓝羽鸡，大保J发廊老板兼伍六七的刺客经理人，为了赚大钱怂恿伍六七当刺客，实际身份不明 [30] 。

小飞鸡
配音：赵寒
蠢萌鸡大保的养子，鸡大飞的儿子。是一只擅长飞行的鸡，负责运送伍六七到任务地点。愤怒时会激发他的隐藏能力，进入另外一个形态。

梅花十三
配音：段艺璇
冷酷、果断，故事女主角，玄武国女刺客，排名37位，擅长使用双刀流和梅花镖，发辫上的短刃可以用于攻击。

猫小咪
配音：江惠琴
猫星人的首领，技能是金刚猫爪。

汪疯
配音：赵成晨
汪星人的汪疯。

斯特国王子
配音：文森
沉着冷静，是斯坦国的王子。擅长使用高科技武器。

可乐
配音：赵寒 [28]
异能美少女。

江主任
配音：刘晓倩
小鸡岛纯净协会主任。

何大春
配音：斑马
小鸡岛的保镖。

陈伯
小鸡岛海防部主任。"""),
              ),
            ),
            SliverToBoxAdapter(
              child: ControllerOffsetWidget(
                  key: testKey,
                  controller: ScrollController(),
                  child: Image.network(
                      "https://img.zcool.cn/community/0180aa60ce03a811013f47204ea5a0.jpg@1280w_1l_2o_100sh.jpg")),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "动画制作",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text("""制作人员
出品人：邹沙沙、何小疯（何伟锋）
原著、导演、系列构成、编剧：何小疯（何伟锋）
角色设计：何小疯、梁昕如
总制片人：邹沙沙
监制：罗浩、张琪
策划：孙华松、王思晓
制片人：朱菁
执行制片人：赵寒
宣传发行：啊哈娱乐（上海）有限公司
音乐制作发行：奔跑怪物
配音制作：光合积木
配音导演：姜广涛
动画制作：广州小疯文化传播有限公司
制作：啊哈娱乐（上海）有限公司、广州小疯文化传播有限公司、上海幻星文化传媒有限公司 [6] [10]"""),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "角色配音",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text("""伍六七：何小疯（何伟锋）
鸡大保：姜广涛
梅花十三：段艺璇、曾蓉（小）
斯坦国小机器人：赵寒
陈伯：侯俊杰
阿婆孙子（小龙）：朱毛
江主任：刘小倩
烧烤摊老板：陈世豪 [10]
猫小咪：江惠琴
汪疯：赵成晨 [11]
陈阿婆：刘晓倩 [13]
可乐：朱蓉蓉 [14]
杰克船长：袁聪宇
阿俊：陈世豪
阿杰：侯俊杰 [15]
何大春：斑马 [16]
斯特国王子：文森 [17]
十三师傅：姜广涛 [18]
小飞鸡：赵寒 [19]"""),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "剧集信息",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "各集制作",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text("""第1话
杀坏人赚大钱
何小疯
何小疯
第2话
刺瞎你的狗眼
第3话
六七VS十三
何小疯
陈嘉杰
第4话
刺杀最强阿婆
何小疯
第5话
刺杀美少女
何小疯
陈嘉杰
第6话
刺杀杰克船长
第7话
保镖大春
何小疯
第8话
小岛危机
第9话
魔刀千刃
番外1
梅花十三
番外2
鸡中霸王（上）
何小疯
陈嘉杰
番外3
鸡中霸王（中）
番外4
鸡中霸王（下）
何小疯
陈嘉杰
候俊杰
陈世豪"""),
              ),
            )
          ],
        ),
      );
    });
  }
}
