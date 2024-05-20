import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ConfigModule, ConfigService } from '@nestjs/config';
import configuration from './config/configuration';
import { join } from 'path';
import { AuthModule } from './modules/auth.module';
import { DataSource } from 'typeorm';
import { UserModule } from './modules/user.module';
import { MenuModule } from './modules/menu.module';
import { RoleModule } from './modules/role.module';
import { ChatModule } from './modules/chat.module';
import { PromptModule } from './modules/prompt.module';
import { DictModule } from './modules/dict.module';
import { FileModule } from './modules/file.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      load: [configuration],
    }),
    // MulterModule.registerAsync({
    //   useFactory() {
    //     return {
    //       storage: diskStorage({
    //         //文件储存位置
    //         destination: 'upload-files',
    //         //文件名定制
    //         filename: (req, file, callback) => {
    //           const path = Date.now() + '-' + uuidv4() + extname(file.originalname);
    //           callback(null, path);
    //         },
    //       }),
    //     };
    //   },
    // }),

    TypeOrmModule.forRootAsync({
      useFactory: (configService: ConfigService) => ({
        type: 'mysql',
        host: configService.get<string>('mariadb.host'),
        port: configService.get<number>('mariadb.port'),
        username: configService.get<string>('mariadb.username'),
        password: configService.get<string>('mariadb.password'),
        database: configService.get<string>('mariadb.database'),
        charset: configService.get<string>('mariadb.charset'),
        entities: [join(__dirname, './**/*.entity.{ts,js}')],
        synchronize: false,
      }),
      inject: [ConfigService],
    }),
    AuthModule,
    UserModule,
    MenuModule,
    RoleModule,
    ChatModule,
    PromptModule,
    DictModule,
    FileModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {
  constructor(
    private readonly dataSource: DataSource,
    private configService: ConfigService,
  ) {}
}
