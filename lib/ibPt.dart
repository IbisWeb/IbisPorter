abstract class Resolver<T,S>{
  T resolve(S arg);
}
class IbPtElment{
  bool get isInvalid => false;
  bool get isContainer => false;
}
class IbPtFacade extends IbPtElment{
  void init(){}
  void update(){
  }
  void create(){}
  void fetch(){}
  void serve(){}
  void build(){}
}
class IbptManifestElm extends IbPtElment{}
class IbptManifestVoid extends IbptManifestElm{
  IbptManifestVoid();
  @override
  bool get isInvalid => true;
}
class IbptManifest extends IbptManifestElm{
  Map<String,IbptManifestElm> _record = {};
  List<IbptManifest> _used = [];
  IbptManifest();
  IbptManifestElm getRecord(String key){
    if(this._record.containsKey(key)){
      return this._record[key]!;
    }else if(this._used.length > 0){
      List<IbptManifestElm> ret = this._used.map((IbptManifest use)=>use.getRecord(key)).where((IbptManifestElm el)=> !(el.isInvalid)).toList();
      if(ret.length > 0){
        return ret.first;
      }else{
        return IbptManifestVoid();
      }
    }else{
      return IbptManifestVoid();
    }
  }
  @override
  bool get isContainer => true;
}
class ManifestResolver extends IbPtElment implements Resolver<String IbptManifest>{}
class URIResolver implements Resolver<String,String>{
  String resolve(String uri){}
  String valdate(String uri){}
}
class 