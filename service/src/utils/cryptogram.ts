import * as bcrypt from 'bcrypt';

/**
 * 生成hash 密码，hash 10次
 *
 * @param password
 * @returns
 */
export const genPassowrd = (password: string) => {
  // hash 密码10次
  const saltRounds = 10;
  const passwordHash = bcrypt.hash(password, saltRounds);

  return passwordHash;
};
