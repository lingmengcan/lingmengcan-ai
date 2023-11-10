import { renderIcon } from '@/utils';
import { DashboardOutlined, SketchOutlined, MonitorOutlined } from '@vicons/antd';
import { BrushOutline, ChatboxOutline, OptionsSharp } from '@vicons/ionicons5';

//前端路由图标映射表
export const constantRouterIcon = {
  DashboardOutlined: renderIcon(DashboardOutlined),
  SketchOutlined: renderIcon(SketchOutlined),
  BrushOutline: renderIcon(BrushOutline),
  ChatboxOutline: renderIcon(ChatboxOutline),
  OptionsSharp: renderIcon(OptionsSharp),
  MonitorOutlined: renderIcon(MonitorOutlined),
};
