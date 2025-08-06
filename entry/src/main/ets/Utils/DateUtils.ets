import { BusinessError, systemDateTime } from '@kit.BasicServicesKit';

class DateUtil {
  private date: string = ''

  beginTime(): string {
    systemDateTime.getTimezone((error: BusinessError, data: string) => {
      this.date = data;
    });
    return this.date
  }

  beginTimeOfDay(date: Date) {
    let d = new Date(date.getFullYear(), date.getMonth(), date.getDay())
    return d.getTime()
  }

  timestampToDate(timestamp: number): string {
    const date = new Date(timestamp); // 将时间戳转为 Date 对象

    // 格式化时间
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0'); // 月份从 0 开始，需要加 1
    const day = String(date.getDate()).padStart(2, '0');

    // 拼接成需要的格式
    return `${year}-${month}-${day}`;
  }
}


let dateUtil = new DateUtil()

export default dateUtil as DateUtil