//エラーメッセージを日本語に変換する
String getJapaneseErrorMessage(String code) {
  switch (code) {
    case 'invalid-email':
      return 'メールアドレスの形式が正しくありません。';
    case 'user-disabled':
      return 'このユーザーアカウントは無効化されています。';
    case 'user-not-found':
      return 'ユーザーが見つかりません。';
    case 'wrong-password':
      return 'パスワードが間違っています。';
    case 'email-already-in-use':
      return 'このメールアドレスは既に使用されています。';
    case 'operation-not-allowed':
      return 'この操作は許可されていません。';
    case 'weak-password':
      return 'パスワードが簡単すぎます（6文字以上にしてください）。';
    default:
      return '不明なエラーが発生しました（$code）';
  }
}
