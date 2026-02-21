一看类型是否相同，二看是否有Key，同时只关注本层级，如添加一个Center那Key是不会去找的，找不到的Key就会把自己的Element 消亡了

Widget 和 Element 分开是为了绘制效率，Widget负责组件形状，Element负责储存参数,即Widget和State各管各的，build context 就是 Element 的入口

StatlessWidget 永远不需要用到Key， CTRL + 点击查看Widget状态
