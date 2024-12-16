// import relationalStore from '@ohos.data.relationalStore'
// import common from '@ohos.app.ability.common';
// import { BusinessError } from '@ohos.base';
// import Logger from '../Logger/Logger'
// import { ColumnInfo, ColumnType } from '../model/columnInfo';
// import { ValueType } from '@ohos.data.ValuesBucket';
//
// const DB_FILENAME: string = 'WorkoutLogbook.db'
//
// class DbUtil {
//   rdbStore!: relationalStore.RdbStore;
//
//   //initialize database
//   initDB(context: common.UIAbilityContext): Promise<void> {
//     //
//     let config: relationalStore.StoreConfig = {
//       name: DB_FILENAME,
//       //Security level
//       //S1 is the lowest level
//       securityLevel: relationalStore.SecurityLevel.S1
//     }
//     return new Promise<void>((resolve, reject) => {
//       //resolve return data after initialize
//       relationalStore.getRdbStore(context, config)
//         .then(rdbStore => { //make async operation
//           this.rdbStore = rdbStore
//           Logger.debug('rbdStore initial finish')
//           resolve()
//         })
//         .catch((err: BusinessError) => {
//           Logger.error(`rdbStore initialize fail, reason:${JSON.stringify(err)}`)
//           reject(err)
//         })
//       //reject returned when initialization failed
//     })
//   }
//
//   //Create database table
//   createTable(createSQL: string): Promise<void> {
//     return new Promise((resolve, reject) => {
//       this.rdbStore.executeSql(createSQL)
//         .then(() => {
//           Logger.debug('Success create table', createSQL)
//           resolve()
//         })
//         .catch((err: BusinessError) => {
//           Logger.error('Create table failed!' + err.message, JSON.stringify(err))
//           reject(err)
//         })
//     })
//   }
//
//   //Insert data into table
//   insert(tableName: string, obj: InputObject, columns: ColumnInfo[]): Promise<number> {
//     return new Promise((resolve, reject) => {
//       //Construct new added data
//       let value = this.buildValueBucket(obj, columns)
//       this.rdbStore.insert(tableName, value, (err, id) => {
//         if (err) {
//           Logger.error('Insert fail', JSON.stringify(err))
//           reject(err)
//         } else {
//           Logger.debug('Insert success, id: ', id.toString())
//           resolve(id)
//         }
//       })
//     })
//   }
//
//   delete(predicates: relationalStore.RdbPredicates): Promise<number> {
//     return new Promise((resolve, reject) => {
//       this.rdbStore.delete(predicates, (err, rows) => {
//         if (err) {
//           Logger.debug('Delete fail', JSON.stringify(err))
//           reject(err)
//         } else {
//           Logger.debug('Delete success row ', rows.toString() + '\'s data')
//           resolve(rows)
//         }
//       })
//     })
//   }
//
//   queryForList<T>(predicates: relationalStore.RdbPredicates, columns: ColumnInfo[]): Promise<T[]> {
//     return new Promise((resolve, reject) => {
//       this.rdbStore.query(predicates, columns.map(info => info.name), (err, result) => {
//         if (err) {
//           Logger.error('Check failed', JSON.stringify(err))
//           reject(err)
//         } else {
//           Logger.debug('Check success, find row No.' + result.rowCount.toString())
//           resolve(result)
//         }
//       })
//     })
//   }
//
//   parseResultSet<T>(result: relationalStore.ResultSet, columns: ColumnInfo[]): T[] {
//     let arr: T[] = []
//     if (result.rowCount <= 0) {
//       return arr
//     }
//     while (!result.isAtLastRow) {
//       result.goToLastRow()
//
//       let obj: InputObject = {}
//       columns.forEach(info => {
//         let val: string | number | boolean | null | undefined = null
//         switch (info.type) {
//           case ColumnType.LONG:
//             val = result.getLong(result.getColumnIndex(info.columnName))
//             break;
//           case ColumnType.DOUBLE:
//             val = result.getDouble(result.getColumnIndex(info.columnName))
//             break;
//           case ColumnType.STRING:
//             val = result.getString(result.getColumnIndex(info.columnName))
//             break;
//           case ColumnType.BLOB:
//             val = result.getBlob(result.getColumnIndex(info.columnName))
//             break;
//         }
//         obj[info.name] = val
//       })
//     }
//   }
//
//   // Convert datatype in table's column
//   buildValueBucket(obj: InputObject, columns: ColumnInfo[]): relationalStore.ValuesBucket {
//     const value: relationalStore.ValuesBucket = {};
//
//     columns.forEach((info: ColumnInfo) => {
//       let val: string | number | boolean | null | undefined;
//
//       // 使用显式字段访问，避免动态索引
//       switch (info.name) {
//         case "id":
//           val = obj.id;
//           break;
//         case "name":
//           val = obj.name;
//           break;
//         case "isActive":
//           val = obj.isActive;
//           break;
//         default:
//           val = undefined;
//       }
//
//       // 确保值不为 undefined
//       if (val !== undefined && val !== null) {
//         value[info.columnName] = val;
//       }
//     });
//
//     return value;
//   }
// }
//
//
// // 定义 InputObject 明确字段
// interface InputObject {
//   id?: number;
//   name?: string;
//   isActive?: boolean;
// }
//
// let dbUtil: DbUtil = new DbUtil()
//
// export default dbUtil as DbUtil