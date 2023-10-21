import { Body, Controller, Get, Post, Req, Session } from '@nestjs/common';
import { AppService } from './app.service';
import { AuthService } from './services/auth.service';
import { successJson } from './utils/result';
import { LoginDto } from './dtos/auth.dto';

@Controller()
export class AppController {
  constructor(
    private readonly appService: AppService,
    private readonly authService: AuthService,
  ) {}

  @Get()
  getHello(): string {
    return this.appService.getHello();
  }

  /**
   * 获取验证码
   * @param req
   */
  @Get('captcha')
  async generateCaptcha(@Req() req: any) {
    const captcha = await this.authService.generateCaptcha();
    // 这里后续要改为分布式redis 过期时间3分钟
    req.session.captcha = captcha.text;

    return successJson(Buffer.from(captcha.data).toString('base64'));
  }

  @Post('login')
  async login(@Body() loginDto: LoginDto, @Session() session: any) {
    const captcha = session?.captcha;
    // 生成令牌
    return this.authService.login(loginDto, captcha);
  }
}
