export class Convert {
  /**
   * @description:  json转model
   * @param {string} json
   * @return {*}
   */
  public static jsonToModel<T>(json: string): T {
    return JSON.parse(json) as T;
  }

  /**
   * @description: model转json
   * @param {any} model
   * @return {*}
   */
  public static modelToJson(model: any): string {
    return JSON.stringify(model);
  }
}
