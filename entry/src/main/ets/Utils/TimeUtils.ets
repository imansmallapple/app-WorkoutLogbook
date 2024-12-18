class TimeUtil {
  formatMilliseconds(ms: number) {
    // 计算小时、分钟和秒
    const hours = Math.floor(ms / (1000 * 60 * 60));
    const minutes = Math.floor((ms % (1000 * 60 * 60)) / (1000 * 60));
    const seconds = Math.floor((ms % (1000 * 60)) / 1000);

    // 格式化为两位数并拼接字符串
    const formattedHours = hours > 0 ? `${hours}h` : '';
    const formattedMinutes = minutes > 0 ? `${minutes}m` : '';
    const formattedSeconds = `${seconds}s`;

    return `${formattedHours}${formattedMinutes}${formattedSeconds}`;
  }

  formatHoursToHM(hours: number) {
  // 提取整数小时和小数部分
  const wholeHours = Math.floor(hours);
  const minutes = Math.round((hours - wholeHours) * 60); // 转换为分钟

  // 格式化为字符串
  const formattedHours = `${wholeHours}h`;
  const formattedMinutes = minutes > 0 ? `${minutes}m` : '';

  return `${formattedHours}${formattedMinutes}`;
}
}

const timeUtil = new TimeUtil()

export default timeUtil as TimeUtil