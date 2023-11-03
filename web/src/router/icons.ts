import { renderIcon } from '@/utils';
import { DashboardOutlined, SketchOutlined } from '@vicons/antd';
import { BrushOutline, ChatboxOutline } from '@vicons/ionicons5';

//前端路由图标映射表
export const constantRouterIcon = {
  DashboardOutlined: renderIcon(DashboardOutlined),
  SketchOutlined: renderIcon(SketchOutlined),
  BrushOutline: renderIcon(BrushOutline),
  ChatboxOutline: renderIcon(ChatboxOutline),
};
