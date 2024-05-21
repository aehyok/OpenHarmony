import common from '@ohos.app.ability.common';
import preferences from '@ohos.data.preferences';

class LocalStorage {
  perfMap : Map<string, preferences.Preferences> = new Map()

  async loadPreference(context: common.UIAbilityContext, name:string) {
    try {
      let pref = await preferences.getPreferences(context, name)
      this.perfMap.set(name, pref)
    } catch (e) {
      console.log(JSON.stringify(e), "catch")
    }
  }

  async setValue(name: string, key: string, value: preferences.ValueType) {
    if(!this.perfMap.has(name)){
      return;
    }
    let pref = this.perfMap.get(name)
    await pref?.putSync(key, value)

    await pref?.flush()
  }

  async getValue(name: string, key: string, defaultValue: preferences.ValueType) {
    if(!this.perfMap.has(name)){
      return;
    }
    let pref = this.perfMap.get(name)
    let value = await pref?.getSync(key,defaultValue)

    return value
  }

  async deleteValue(name: string, key: string) {
    if(!this.perfMap.has(name)) {
      return;
    }
    let pref = this.perfMap.get(name)

    await pref?.deleteSync(key)
  }
}

const localStorage = new LocalStorage()

export default  localStorage as LocalStorage