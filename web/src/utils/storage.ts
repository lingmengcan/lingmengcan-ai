// 默认缓存期限为1天
const DEFAULT_CACHE_TIME = 60 * 60 * 24;

/**
 * 创建本地缓存对象
 * @param {string=} prefixKey -
 * @param {Object} [storage=localStorage] - sessionStorage | localStorage
 */
export class DataStorage {
  private storage: globalThis.Storage;
  private prefixKey?: string;

  constructor(prefixKey = '', storage = localStorage) {
    this.storage = storage;
    this.prefixKey = prefixKey;
  }

  private getKey(key: string) {
    return `${this.prefixKey}${key}`.toUpperCase();
  }

  /**
   * @description 设置缓存
   * @param {string} key 缓存键
   * @param {*} value 缓存值
   * @param expire
   */
  set(key: string, value: any, expire: number | null = DEFAULT_CACHE_TIME) {
    const stringData = JSON.stringify({
      value,
      expire: expire !== null ? new Date().getTime() + expire * 1000 : null,
    });
    this.storage.setItem(this.getKey(key), stringData);
  }

  /**
   * 读取缓存
   * @param {string} key 缓存键
   * @param {*=} def 默认值
   */
  get(key: string, def: any = null) {
    const item = this.storage.getItem(this.getKey(key));

    if (item) {
      try {
        const data = JSON.parse(item);

        const { value, expire } = data;
        // 在有效期内直接返回
        if (expire === null || expire >= Date.now()) {
          return value;
        }
        this.remove(key);
      } catch (e) {
        return def;
      }
    }
    return def;
  }

  /**
   * 从缓存删除某项
   * @param {string} key
   */
  remove(key: string) {
    this.storage.removeItem(this.getKey(key));
  }

  /**
   * 清空所有缓存
   * @memberOf Cache
   */
  clear(): void {
    this.storage.clear();
  }
}

const storage = new DataStorage('');

export default storage;
