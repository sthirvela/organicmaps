final class BookmarksListRouter {
  private let mapViewController: MapViewController
  private weak var coordinator: BookmarksCoordinator?

  init(_ mapViewController: MapViewController, bookmarksCoordinator: BookmarksCoordinator?) {
    self.mapViewController = mapViewController
    self.coordinator = bookmarksCoordinator
  }
}

extension BookmarksListRouter: IBookmarksListRouter {
  func listSettings(_ bookmarkGroup: BookmarkGroup, delegate: CategorySettingsViewControllerDelegate?) {
    let listSettingsController = CategorySettingsViewController(bookmarkGroup: bookmarkGroup)
    listSettingsController.delegate = delegate
    mapViewController.navigationController?.pushViewController(listSettingsController, animated: true)
  }
  
  func viewOnMap(_ bookmarkGroup: BookmarkGroup) {
    coordinator?.hide(categoryId: bookmarkGroup.categoryId)
  }

  func showDescription(_ bookmarkGroup: BookmarkGroup) {
//    let descriptionViewController = GuideDescriptionViewController(category: bookmarkGroup)
//    mapViewController.navigationController?.pushViewController(descriptionViewController, animated: true)
  }

  func showSubgroup(_ subgroupId: MWMMarkGroupID) {
    let bookmarksListViewController = BookmarksListBuilder.build(markGroupId: subgroupId,
                                                                 bookmarksCoordinator: coordinator)
    mapViewController.navigationController?.pushViewController(bookmarksListViewController, animated: true)
  }
  
  func selectGroup(currentGroupName groupName: String,
                   currentGroupId groupId: MWMMarkGroupID,
                   delegate: SelectBookmarkGroupViewControllerDelegate?) {
    let groupViewController = SelectBookmarkGroupViewController(groupName: groupName, groupId: groupId)
    groupViewController.delegate = delegate
    mapViewController.navigationController?.pushViewController(groupViewController, animated: true)
  }
  
  func editBookmark(bookmarkId: MWMMarkID, completion: @escaping (Bool) -> Void) {
    let editBookmarkController = UIStoryboard.instance(.main).instantiateViewController(withIdentifier: "MWMEditBookmarkController") as! EditBookmarkViewController
    editBookmarkController.configure(with: bookmarkId, editCompletion: completion)
    mapViewController.navigationController?.pushViewController(editBookmarkController, animated: true)
  }
  
  func editTrack(trackId: MWMTrackID, completion: @escaping (Bool) -> Void) {
    let editTrackController = EditTrackViewController(trackId: trackId, editCompletion: completion)
    mapViewController.navigationController?.pushViewController(editTrackController, animated: true)
  }
}
